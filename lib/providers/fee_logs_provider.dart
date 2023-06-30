import 'package:feemanagement/models/student_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FeeLogsNotifier extends StateNotifier<List<FeeLog>> {
  FeeLogsNotifier() : super([]);

  void addToLogs(FeeLog addLog) {
    // final List<FeeLog> feeLogs = state;
    state = [...state, addLog];
    debugPrint("Added Log = ${addLog.studentId} ${addLog.transactionAmount} ${addLog.feePaidDate}");
  }

  void removeFromLogUsingLogID(String removeLogID) {
    state = state.where((element) => element.logID != removeLogID).toList();
    debugPrint("Removed Log = $removeLogID");
  }
  void removeAllLogsUsingStudentId(String studentId) {
    state = state.where((element) => element.studentId != studentId).toList();
    // debugPrint("Removed Log = $removeLog");
  }
}

final feeLogsProvider = StateNotifierProvider<FeeLogsNotifier, List<FeeLog>>(
    (ref) => FeeLogsNotifier());
