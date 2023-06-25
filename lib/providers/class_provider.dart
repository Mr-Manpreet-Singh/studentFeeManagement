import 'package:flutter_riverpod/flutter_riverpod.dart';

class StudentClassNotifier extends StateNotifier<List<String>> {
   StudentClassNotifier() : super([]);

  void addClassToList(String newClass) {
    state = [...state, newClass];
  }

  void removeClassfromList(String removeClass) {
    final List<String> classAfterRemove =
        state.where((element) => element != removeClass).toList();
    state = classAfterRemove;
  }
}

final studentClassProvider =
    StateNotifierProvider<StudentClassNotifier, List<String>>(
        (ref) => StudentClassNotifier());
