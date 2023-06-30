import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:feemanagement/models/student_model.dart';
import 'package:feemanagement/providers/fee_logs_provider.dart';
import 'package:feemanagement/providers/student_provider.dart';
import 'package:feemanagement/screens/student_details.dart';
import 'package:feemanagement/widgets/floating_button.dart';

class StudentList extends ConsumerStatefulWidget {
  const StudentList({super.key, required this.currentClass});
  final String currentClass;

  @override
  ConsumerState<StudentList> createState() => _StudentListState();
}

class _StudentListState extends ConsumerState<StudentList> {
  void onCurrencyIconTap(Student currentStudent) {
    final feeController = TextEditingController();
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: TextField(
                decoration: const InputDecoration(labelText: "Amount"),
                keyboardType: TextInputType.number,
                controller: feeController,
              ),
              title: const Text("Enter Amount"),
              actionsAlignment: MainAxisAlignment.end,
              actions: [
                TextButton(
                    onPressed: (feeController.text.isEmpty)
                        ? () {
                            onPay(currentStudent, feeController.text);
                          }
                        : null,
                    child: const Text("Pay"))
              ],
            ));
  }

  void onPay(Student student, String amount) {
    final addPayment = int.tryParse(amount);
    if (addPayment != null && addPayment > 0) {
      debugPrint("${student.id} Log Added on Studdent Id = ");
      Navigator.of(context).pop();
      // send data to provider to add log
      ref.read(feeLogsProvider.notifier).addToLogs(FeeLog(
          feePaidDate: DateTime.now(),
          transactionAmount: addPayment,
          studentId: student.id));
      ref
          .read(studentsProvider.notifier)
          .alreadyPaidFeeStatus(student, addPayment);

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Fee paid Successfully")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final allStudentsList = ref.watch(studentsProvider);
    debugPrint("All student list Fetched");
    // final studentsList = students;
    final studentsList = allStudentsList
        .where((element) => element.studentClass == widget.currentClass)
        .toList();
    final List<FeeLog> allLogs = ref.watch(feeLogsProvider);
    List<FeeLog> allSortedLogs = allLogs;
    allSortedLogs.sort(
      (a, b) => b.feePaidDate.compareTo(a.feePaidDate),
    );

    return Scaffold(
      appBar: AppBar(title: Text("Batch ${widget.currentClass}")),
      body: ListView.builder(
        itemCount: studentsList.length,
        itemBuilder: (context, index) {
          final lastLatestLogs = allSortedLogs.firstWhere(
            (element) => element.studentId == studentsList[index].id,
          );
          return Card(
            key: ValueKey(studentsList[index].id),
            child: ListTile(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => StudentDetails(
                  currentStudent: studentsList[index].copyWith(),
                ), //pass student
                // builder: (context) => StudentDetails(), //pass student
              )),
              title: Text(studentsList[index].name),
              subtitle:  Row(
                children: [Text("Fee Last Paid:"),
                  Text(DateFormat("dd-MMM-yy : HH:mm").format(lastLatestLogs.feePaidDate),style: TextStyle(color: ((DateTime.now().difference(lastLatestLogs.feePaidDate) > Duration(days: 30))?Colors.red:Colors.green),),),
                ],
              ),
              trailing: IconButton.filled(
                  onPressed: () => onCurrencyIconTap(studentsList[index]),
                  icon: const Icon(Icons.currency_rupee_sharp)),
            ),
          );
        },
      ),
      floatingActionButton: FloatingButton(selectedClass: widget.currentClass),
    );
  }
}
