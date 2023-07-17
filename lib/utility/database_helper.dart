import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:feemanagement/models/student_feelog_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _getDataBase();
    return _database!;
  }

  //  creating table if not created opening database getiing database opened..
  static Future<Database> _getDataBase() async {
    final dbDir = await sql.getDatabasesPath();
    final dbPath = path.join(dbDir, 'feeManagement.db');
    final db = await sql.openDatabase(
      dbPath,
      onCreate: (db, version) {
        db.execute(
            'CREATE TABLE IF NOT EXISTS studentTable (id TEXT PRIMARY KEY, registeredDate TEXT, name TEXT, studentClass TEXT, totalFee INTEGER, alreadyFeePaid INTEGER)');
        db.execute(
            'CREATE TABLE IF NOT EXISTS feeLOGTable (logId TEXT PRIMARY KEY, studentId TEXT, feePaidDate TEXT, transactionAmount INTEGER)');
      },
      version: 1,
    );
    return db;
  }

// -------------  Operations on Log Table

  static void insertLog(Map<String, dynamic> newLogdataMap) async {
    final db = await _getDataBase();
    final int count = await db.insert('feeLOGTable', newLogdataMap);
    debugPrint("$count : Log Inserted in table");
  }

  static void deleteLogByLogId(String idTODelLog) async {
    final db = await _getDataBase();

    final int count = await db
        .delete('feeLOGTable', where: "logID = ?", whereArgs: [idTODelLog]);
    debugPrint("$count : count of deleted logs by logId");
  }

  static void removeAllLogsOfStudent(String studentIDtoDelLogs) async {
    final db = await _getDataBase();

    final int count = await db.delete('feeLOGTable',
        where: "studentId = ?", whereArgs: [studentIDtoDelLogs]);
    debugPrint("$count : count of deleted logs by studentID");
  }

  static Future<List<FeeLog>> getAllLogs() async {
    final db = await _getDataBase();
    final data = await db.query("feeLOGTable");
    final List<FeeLog> allLogs = data
        .map((row) => FeeLog(
            studentId: row['studentId'] as String,
            feePaidDate: DateTime.parse(row['feePaidDate'] as String),
            transactionAmount: row['transactionAmount'] as int,
            id: row['logId'] as String))
        .toList();

    return allLogs;
  }

// ---------------   Operations on Student Tables

  static void insertStudent(Map<String, dynamic> newStudentDetailsMap) async {
    final db = await _getDataBase();
    final int count = await db.insert('studentTable', newStudentDetailsMap);
    debugPrint("$count : Student Inserted in table");
  }

  static void deleteStudentByStudentId(String idTODelStudent) async {
    final db = await _getDataBase();

    final int count = await db
        .delete('studentTable', where: "id = ?", whereArgs: [idTODelStudent]);
    debugPrint("$count : count of student Deleted ");
  }

  static void updatePaidFeeStatus(
      String studentId, Map<String, dynamic> data) async {
    final db = await _getDataBase();
    final int count = await db
        .update("studentTable", data, where: "id = ?", whereArgs: [studentId]);
  }

  static Future<List<Student>> getAllStudents() async {
    final db = await _getDataBase();
    final data = await db.query("studentTable");
    final List<Student> allStudents = data
        .map((row) => Student(
            name: row['name'] as String,
            studentClass: row['studentClass'] as String,
            totalFee: row['totalFee'] as int,
            alreadyFeePaid: row['alreadyFeePaid'] as int,
            id: row['id'] as String,
            registeredDate: DateTime.parse(row['registeredDate'] as String)))
        .toList();

    return allStudents;
  }

  static Future<List<String>> getAllClasses() async {
    final db = await _getDataBase();
    final data = await db.query("studentTable");
    final List<String> allClasses =
        data.map((row) => row['studentClass'] as String).toList();

    //  removing duplicates
    final allUniqueClasses = allClasses.toSet().toList();

    return allUniqueClasses;
  }

// ------------------ operations on both

  static void deleteAllStudentsAndLogByClass(String studentClass) async {
    final db = await _getDataBase();
    // final List<String> listOfStudentsid = await db.query('studentTable',where: "studentClass = ?",whereArgs: [studentClass]);
    final List<Map<String, dynamic>> maps = await db.query("studentTable",
        columns: ['id'], where: 'studentClass = ?', whereArgs: [studentClass]);
    final List<String> listOfStudentsId =
        maps.map((map) => map['id'] as String).toList();
    final studentCount = await db.delete(
      'studentTable',
      where: "studentClass = ?",
      whereArgs: [studentClass],
    );

    // final logsCount =
    //     await db.delete('feeLOGTable', where: "studentId =?", whereArgs: listOfStudentsId);
    final whereClause =
        'studentId = ? OR ' * (listOfStudentsId.length - 1) + 'studentId = ?';
    final logsCount = await db.delete('feeLOGTable',
        where: whereClause, whereArgs: listOfStudentsId);

    debugPrint("${studentCount} : deleted Student Count ");
    debugPrint("${logsCount} : deleted LOgs Count ");
  }
}
