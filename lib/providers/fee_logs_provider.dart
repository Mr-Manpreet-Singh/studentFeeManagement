import 'package:feemanagement/models/student_model.dart';
import 'package:feemanagement/utility/database_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// DatabaseHelper dbHelper = DatabaseHelper();

class FeeLogsNotifier extends StateNotifier<List<FeeLog>> {
  FeeLogsNotifier() : super([]);

  Future<void> getLogsFromDb() async {
    final allLogs = await DatabaseHelper.getAllLogs();
    state = allLogs;
  }

  void addToLogs(FeeLog addLog) {
    // final List<FeeLog> feeLogs = state;
    state = [...state, addLog];
    debugPrint(
        "Added Log = ${addLog.studentId} ${addLog.transactionAmount} ${addLog.feePaidDate}");

    insertLogtoDb(addLog);
  }

  void removeFromLogUsingLogID(String removeLogID) {
    state = state.where((element) => element.logID != removeLogID).toList();
    // debugPrint("Removed Log = $removeLogID");
    deleteLogfromDbUsingLogId(removeLogID);
  }

  void removeAllLogsUsingStudentId(String studentId) {
    state = state.where((element) => element.studentId != studentId).toList();
    deleteLogfromDbUsingStudenId(studentId);
  }
}

final feeLogsProvider = StateNotifierProvider<FeeLogsNotifier, List<FeeLog>>(
    (ref) => FeeLogsNotifier());

void insertLogtoDb(FeeLog log) async {
  final Map<String, dynamic> data = {
    "logId": log.logID,
    "studentId": log.studentId,
    "feePaidDate": "${log.feePaidDate}",
    "transactionAmount": log.transactionAmount
  };
  DatabaseHelper.insertLog(data);
  debugPrint('Insert Fun called from Provider to database');
}

void deleteLogfromDbUsingLogId(String removeLogID) async {
  DatabaseHelper.deleteLogByLogId(removeLogID);
  debugPrint('delLog Fun called from Provider to database');
}

void deleteLogfromDbUsingStudenId(String studentId) async {
  DatabaseHelper.removeAllLogsOfStudent(studentId);
  debugPrint('del All Logs Fun called from Provider to database');
}
