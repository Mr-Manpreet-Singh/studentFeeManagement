import 'package:feemanagement/models/student_model.dart';
import 'package:feemanagement/providers/fee_logs_provider.dart';
import 'package:feemanagement/providers/student_provider.dart';
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

  void _onUndoLogTap(WidgetRef ref, BuildContext context) {
    // showDialog(
    //     context: context,
    //     builder: (context) {

          

    //       return AlertDialog(
    //         title: const Text("Undo Last Log"),
    //         actions: [
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.end,
    //             children: [
    //               TextButton(
    //                   onPressed: () {
    //                     Navigator.of(context).pop();
    //                   },
    //                   child: const Text("No")),
    //               TextButton(
    //                   onPressed: () {
    //                     Navigator.of(context).pop();
    //                     ref.read(feeLogsProvider.notifier).removeFromLogUsingLogID()

    //                   },
    //                   child: const Text("Yes, Undo Log")),
    //             ],
    //           )
    //         ],
    //       );
    //     });
  }


  void _onDeleteTap(WidgetRef ref, BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Delete Student permanently"),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("No")),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        ref
                            .read(studentsProvider.notifier)
                            .removeStudentUsingId(currentStudent.id);
                        ref
                            .read(feeLogsProvider.notifier)
                            .removeAllLogsUsingStudentId(currentStudent.id);

                      },
                      child: const Text("Yes, Delete")),
                ],
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("${currentStudent.id}   st ID on details screen ");
    final formattedDateTime =
        DateFormat('dd-MMM-yy HH:mm').format(currentStudent.registeredDate);
    return Scaffold(
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
            SizedBox(height: 12),
            Card(
              elevation: 3,
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(currentStudent.name),
                    SizedBox(height: 12),
                    Card(
                      elevation: 10,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text("Total"),
                                Text("${currentStudent.totalFee}"),
                              ],
                            ),
                            Column(
                              children: [
                                Text("Paid"),
                                Text("${currentStudent.alreadyFeePaid}"),
                              ],
                            ),
                            Column(
                              children: [
                                Text("Pending"),
                                Text(
                                    "${(currentStudent.totalFee) - (currentStudent.alreadyFeePaid)}"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    Text("Registered on $formattedDateTime"),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text("Fee Log's"),
            SizedBox(
              height: 20,
            ),

            // FeeLogsWidget(studentId: student.id)
            Expanded(child: FeeLogsWidget(studentId: currentStudent.id)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

          ElevatedButton.icon(
              onPressed: () {
                _onDeleteTap(ref, context);
              },
              label: Text("Undo Log"),
              icon: Icon(Icons.undo)),
        
          ElevatedButton.icon(
              onPressed: () {
                _onUndoLogTap(ref, context);// to be done
              },
              label: Text("Delete Student"),
              icon: Icon(Icons.delete)),
        
              ],
            )
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
