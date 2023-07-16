import 'package:feemanagement/models/student_feelog_model.dart';
import 'package:feemanagement/widgets/fee_logs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

//ToDO
//edit details button --> add student screen without allready paid fee
// image foregrounfd and background
// edit buttom functionality
// Undo button student button funcationality

// Learnings delete using ID nothe the complete Model but why ??

class StudentDetails extends ConsumerWidget {
  const StudentDetails({super.key, required this.currentStudent});
  final Student currentStudent;
  // const StudentDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("${currentStudent.id}   st ID on details screen ");
    final formattedDateTime =
        DateFormat('dd-MMM-yy HH:mm').format(currentStudent.registeredDate);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Student Details"),
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Center(
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey[300],
                  child: const Icon(
                    Icons.person,
                    size: 60,
                  ),
                  // backgroundImage: ,
                  // foregroundImage: ,
                ),
              ),
              const SizedBox(height: 12),
              Card(
                elevation: 3,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(currentStudent.name),
                      const SizedBox(height: 12),
                      Card(
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  const Text("Total"),
                                  Text("${currentStudent.totalFee}"),
                                ],
                              ),
                              Column(
                                children: [
                                  const Text("Paid"),
                                  Text("${currentStudent.alreadyFeePaid}"),
                                ],
                              ),
                              Column(
                                children: [
                                  const Text("Pending"),
                                  Text(
                                      "${(currentStudent.totalFee) - (currentStudent.alreadyFeePaid)}"),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text("Registered on $formattedDateTime"),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text("Fee Log's"),
              const SizedBox(
                height: 20,
              ),

              // FeeLogsWidget(studentId: student.id)
              Expanded(child: FeeLogsWidget(studentId: currentStudent.id)),

              // Text("Registered "),
            ],
          ),
        ),
      ),
    );
  }
}
  

// fees log
// Balance
// Undo last fee
// delete student
