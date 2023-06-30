import 'package:feemanagement/screens/add_student.dart';
import 'package:feemanagement/screens/student_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:feemanagement/screens/class__list.dart';

import 'models/student_model.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      home: SafeArea(child: ClassScreen()),
      // home: SafeArea(child: StudentDetails())
    );
  }
}
