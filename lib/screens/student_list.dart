import 'package:feemanagement/providers/student_provider.dart';
import 'package:feemanagement/screens/student_details.dart';
import 'package:feemanagement/widgets/floating_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StudentList extends ConsumerStatefulWidget {
  const StudentList({super.key, required this.currentClass});
  final String currentClass;

  @override
  ConsumerState<StudentList> createState() => _StudentListState();
}

class _StudentListState extends ConsumerState<StudentList> {
  @override
  Widget build(BuildContext context) {
    final allStudentsList = ref.watch(studentsProvider);
    final studentsList = allStudentsList
        .where((element) => element.studentClass == widget.currentClass)
        .toList();
    return Scaffold(
      appBar: AppBar(title:  Text("Class ${widget.currentClass}")),
      body: ListView.builder(
        itemCount: studentsList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>  StudentDetails(student: studentsList[index]), //pass student
              )),
              title: Text(studentsList[index].name),
              subtitle: const Text("Status : pending/ Paid"),
              trailing: IconButton.filled(
                  onPressed: () {},
                  icon: const Icon(Icons.currency_rupee_sharp)),
            ),
          );
        },
      ),
      floatingActionButton: FloatingButton(selectedClass: widget.currentClass),
    );
  }
}
