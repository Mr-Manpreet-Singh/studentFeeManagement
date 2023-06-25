import 'package:feemanagement/models/student_model.dart';
import 'package:flutter/material.dart';

class StudentDetails extends StatelessWidget {
  const StudentDetails({super.key, required this.student});
  final Student student;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Details"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(student.name),
            Text("registered date  = ${student.fee}"),
            Text("${student.regesteredDate}"),
            // Text("Registered "),
          ],
        ),
      ),
    );
  }
}



// fees log
// Balance 
// Undo last fee
// delete student
