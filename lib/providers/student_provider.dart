import 'package:feemanagement/utility/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:feemanagement/models/student_feelog_model.dart';

class StudentsNotifier extends StateNotifier<List<Student>> {
  StudentsNotifier() : super([]);

  Future<void> getAllStudentsfromDb() async {
    final allStudents = await DatabaseHelper.getAllStudents();
    state = allStudents;
  }

  String addStudent(Student saveStudent) {
    state = [...state, saveStudent];
    insertStudenttoDb(saveStudent);
    return saveStudent.id;
  }

  
  void removeStudentUsingId(String studentId) {
    state = state.where((element) => element.id != studentId).toList();
    deleteStudentfromDbUsingStudentId(studentId);
    debugPrint("Student Removed form provider $studentId");
  }

  void alreadyPaidFeeUpdate(String updateStatusUsingStudentId, int addFee) {
    debugPrint("alreadyPaidFeeStatus");
    final index =
        state.indexWhere((student) => student.id == updateStatusUsingStudentId);
    if (index != -1) {
      final updatedStudent = state[index];
      final newPaidFee = updatedStudent.alreadyFeePaid + addFee;
      final newStudent = updatedStudent.copyWith(alreadyFeePaid: newPaidFee);
      state = List.from(state);
      state[index] = newStudent;
      updatePaidFeeStatusInDb(updateStatusUsingStudentId, newStudent);

      debugPrint("${newStudent.id}alreadyPaidFeeStatus");
    }
  }
}

final studentsProvider = StateNotifierProvider<StudentsNotifier, List<Student>>(
  (ref) => StudentsNotifier(),
);

void insertStudenttoDb(Student student) async {
  final Map<String, dynamic> data = {
    "id": student.id,
    "registeredDate": "${student.registeredDate}",
    "name": student.name,
    "studentClass": student.studentClass,
    "totalFee": student.totalFee,
    "alreadyFeePaid": student.alreadyFeePaid
  };
  DatabaseHelper.insertStudent(data);
  debugPrint('Insert student Fun called from Provider to database');
}

void deleteStudentfromDbUsingStudentId(String removeStudentId) async {
  DatabaseHelper.deleteStudentByStudentId(removeStudentId);
  debugPrint('delstudent Fun called from Provider to database');
}

void updatePaidFeeStatusInDb(String studentId, Student updatedStudent) async {
  final Map<String, dynamic> studentDetailsMap = {
    "id": updatedStudent.id,
    "registeredDate": "${updatedStudent.registeredDate}",
    "name": updatedStudent.name,
    "studentClass": updatedStudent.studentClass,
    "totalFee": updatedStudent.totalFee,
    "alreadyFeePaid": updatedStudent.alreadyFeePaid
  };
  DatabaseHelper.updatePaidFeeStatus(studentId, studentDetailsMap);
  debugPrint('del All Logs Fun called from Provider to database');
}
