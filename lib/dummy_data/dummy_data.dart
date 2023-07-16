import 'package:feemanagement/models/student_feelog_model.dart';

List classes = [
  "10-A",
  "10-B",
  "10-C",
  "10-D",
  "10-E",
];

List<Student> students = [
  Student(
      name: "manu", totalFee: 1000, alreadyFeePaid: 100, studentClass: "601"),
  Student(
      name: "man", totalFee: 1100, alreadyFeePaid: 100, studentClass: "602"),
  Student(name: "ma", totalFee: 1200, alreadyFeePaid: 100, studentClass: "603"),
  Student(name: "m", totalFee: 1300, alreadyFeePaid: 100, studentClass: "601"),
  Student(
      name: "manpreeet",
      totalFee: 1400,
      alreadyFeePaid: 100,
      studentClass: "601")
];

List<String> classesss = ["601", "602","603"];
List<String> feeLogs = ["601", "602","603"];


List<FeeLog> dummyFeeLogsss = [
  FeeLog(feePaidDate: DateTime.now(), transactionAmount: 100, studentId: "Abc"),
  FeeLog(feePaidDate: DateTime.now(), transactionAmount: 100, studentId: "Abc"),
  FeeLog(feePaidDate: DateTime.now(), transactionAmount: 100, studentId: "Abc"),
  FeeLog(feePaidDate: DateTime.now(), transactionAmount: 100, studentId: "Abc"),
  FeeLog(feePaidDate: DateTime.now(), transactionAmount: 100, studentId: "Abc"),
  FeeLog(feePaidDate: DateTime.now(), transactionAmount: 100, studentId: "Abc"),
  FeeLog(feePaidDate: DateTime.now(), transactionAmount: 100, studentId: "Abc"),
];



