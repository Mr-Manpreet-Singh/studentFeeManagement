import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:feemanagement/models/student_model.dart';

class StudentsNotifier extends StateNotifier<List<Student>> {
  StudentsNotifier() : super([]);

  String addStudent(Student saveStudent) {
    state = [...state, saveStudent];
    return saveStudent.id;
  }

  void removeStudent(Student removeStudent) {
    state = state.where((element) => element != removeStudent).toList();
    debugPrint("Student Removed form provider ${removeStudent.name}");
  }
  void removeStudentUsingId(String studentId) {
    state = state.where((element) => element.id != studentId).toList();
    debugPrint("Student Removed form provider ${studentId}");
  }

  void alreadyPaidFeeStatus(Student updateStatus, int addFee) {
    debugPrint("alreadyPaidFeeStatus");
    final index = state.indexWhere((student) => student.id == updateStatus.id);
    if (index != -1) {
      final updatedStudent = state[index];
      final newPaidFee = updatedStudent.alreadyFeePaid + addFee;
      final newStudent = updatedStudent.copyWith(alreadyFeePaid: newPaidFee);
      state = List.from(state);
      state[index] = newStudent;
      debugPrint("${newStudent.id}alreadyPaidFeeStatus");
    }
  }
}

final studentsProvider = StateNotifierProvider<StudentsNotifier, List<Student>>(
  (ref) => StudentsNotifier(),
);
