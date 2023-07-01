import 'package:feemanagement/utility/database_helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StudentClassNotifier extends StateNotifier<List<String>> {
  StudentClassNotifier() : super([]);

  Future<void> getAllClassesFromDb() async {
    final allClasses = await DatabaseHelper.getAllClasses();
    state = allClasses;
  }

  void addClassToList(String newClass) {
    state = [...state, newClass];
  }

  void removeClassfromList(String removeClass) {
    removeClasssFromDb(removeClass);
    state = state.where((element) => element != removeClass).toList();
  }
}

final studentClassProvider =
    StateNotifierProvider<StudentClassNotifier, List<String>>(
        (ref) => StudentClassNotifier());

// --> Remove all students + all logs of that students
void removeClasssFromDb(String removeClass) {
  DatabaseHelper.deleteAllStudentsAndLogByClass(removeClass);
}
