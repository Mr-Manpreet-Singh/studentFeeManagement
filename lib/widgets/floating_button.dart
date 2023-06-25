import 'package:feemanagement/screens/add_student.dart';
// import 'package:feemanagement/screens/add_class.dart';
import 'package:flutter/material.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({super.key, required this.selectedClass });
  final String selectedClass;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>  AddStudent(currentClass: selectedClass,) 
            ));
      },
      child: const Icon(Icons.person_add),
    );
  }
}
