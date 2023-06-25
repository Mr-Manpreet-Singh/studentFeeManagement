import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:feemanagement/models/student_model.dart';


class StudentsNotifier extends StateNotifier <List<Student>> {
  StudentsNotifier() : super([]);

  void addStudent(Student saveStudent) {
    state = [...state, saveStudent];
  }

  void removeStudent(Student removeStudent) {
    state = state.where((element) => element != removeStudent).toList();
  }
}

final studentsProvider =
    StateNotifierProvider<StudentsNotifier, List<Student>>(
  (ref) => StudentsNotifier(),
);
