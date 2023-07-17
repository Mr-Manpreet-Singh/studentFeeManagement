import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:feemanagement/models/student_feelog_model.dart';
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
  @override
  void initState() {

    triggerDb();

    super.initState();
  }

  void triggerDb() async {
    await ref.read(studentsProvider.notifier).getAllStudentsfromDb();
    await ref.read(feeLogsProvider.notifier).getLogsFromDb();
  }

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
          .alreadyPaidFeeUpdate(student.id, addPayment);

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Fee paid Successfully")));
    }
  }

  String searchingText = "";

  @override
  Widget build(BuildContext context) {
    // All students
    final allStudentsList = ref.watch(studentsProvider);
    debugPrint("All student list Fetched");
    // Particular class Students
    final studentsList = allStudentsList
        .where((element) => element.studentClass == widget.currentClass)
        .toList();
    // Searching Students
    final List<Student> filteredStudentList = studentsList
        .where((student) => student.name.contains(searchingText))
        .toList();

    // Dealing With Logs
    //  All logs
    final List<FeeLog> allLogs = ref.watch(feeLogsProvider);
    // Sorting logs
    List<FeeLog> allSortedLogs = allLogs;
    allSortedLogs.sort(
      (a, b) => b.feePaidDate.compareTo(a.feePaidDate),
    );

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Batch ${widget.currentClass}"),
          // backgroundColor: Colors.black87,
          // centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              // Search bar

              Container(
                
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      searchingText = value;
                    });
                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: " Search",
                  ),
                ),
              ),

              const SizedBox(height: 10),
              //  List View Builder // Student List

              Expanded(
                child: (filteredStudentList.isEmpty)
                    ? const Center(
                        child: Text("No student Found"),
                      )
                    : ListView.builder(
                        itemCount: filteredStudentList.length,
                        itemBuilder: (context, index) {
                          final FeeLog lastLatestLog = allSortedLogs.firstWhere(
                              (log) =>
                                  log.studentId ==
                                  filteredStudentList[index].id,
                              orElse: () => FeeLog(
                                  feePaidDate: DateTime.now(),
                                  transactionAmount: 0,
                                  studentId: "-1"));

                          return Card(
                            key: ValueKey(filteredStudentList[index].id),
                            child: ListTile(
                              onTap: () =>
                                  Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => StudentDetails(
                                  currentStudent:
                                      filteredStudentList[index].copyWith(),
                                ),
                              )),

                              titleTextStyle: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                              subtitleTextStyle: const TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w600),
                              title: Text(filteredStudentList[index].name),
                              subtitle: (lastLatestLog.studentId != "-1")
                                  ? Row(
                                      children: [
                                        const Text("Fee Last Paid: "),
                                        Text(
                                          DateFormat("dd-MMM-yy : HH:mm")
                                              .format(
                                                  lastLatestLog.feePaidDate),
                                          style: TextStyle(
                                            color: ((DateTime.now().difference(
                                                        lastLatestLog
                                                            .feePaidDate) >
                                                    const Duration(days: 30))
                                                ? Colors.red[800]
                                                : Colors.green[800]),
                                          ),
                                        ),
                                      ],
                                    )
                                  : const Text(""),
                              trailing: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                                ),
                                child: IconButton.filled(
                                    onPressed: () => onCurrencyIconTap(
                                        filteredStudentList[index]),
                                    icon: const Icon(Icons.currency_rupee_sharp , color: Colors.green,size: 25,)),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
        floatingActionButton:
            FloatingButton(selectedClass: widget.currentClass),
      ),
    );
  }
}
