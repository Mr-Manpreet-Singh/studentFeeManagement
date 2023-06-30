import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:feemanagement/models/student_model.dart';
import 'package:feemanagement/providers/student_provider.dart';
import 'package:feemanagement/providers/fee_logs_provider.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/widgets.dart';

class FeeLogsWidget extends ConsumerStatefulWidget {
  const FeeLogsWidget({super.key, required this.studentId});
  final String studentId;

  @override
  ConsumerState<FeeLogsWidget> createState() => _FeeLogsWidgetState();
}

class _FeeLogsWidgetState extends ConsumerState<FeeLogsWidget> {
  void _onUndoLogTap(String logID) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Undo Last Log"),
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
                        ref
                            .read(feeLogsProvider.notifier)
                            .removeFromLogUsingLogID(logID);
                      },
                      child: const Text("Yes, Undo Log")),
                ],
              )
            ],
          );
        });
  }

  void _onDeleteTap() {
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
                            .removeStudentUsingId(widget.studentId);
                        ref
                            .read(feeLogsProvider.notifier)
                            .removeAllLogsUsingStudentId(widget.studentId);
                      },
                      child: const Text("Yes, Delete")),
                ],
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text("No Logs Found"),
    );
    final allLogs = ref.watch(feeLogsProvider);

    // debugPrint("${allLogs[0].studentId}  studn ID of_Log :");
    // debugPrint("${widget.studentId}   st ID recieverd ");

    List<FeeLog> currentStudentLogs = allLogs;
    currentStudentLogs = allLogs
        .where((element) => element.studentId == widget.studentId)
        .toList();

    currentStudentLogs.sort(
      (a, b) {
        return b.feePaidDate.compareTo(a.feePaidDate);
      },
    );

    debugPrint("length =${currentStudentLogs.length}");
    // final currentStudentLogs = dummyFeeLogsss;

    if (currentStudentLogs.isNotEmpty) {
      content = ListView.builder(
        itemCount: currentStudentLogs.length,
        itemBuilder: (context, index) {
          final formattedDateTime = DateFormat('dd-MMM-yy HH:mm')
              .format(currentStudentLogs[index].feePaidDate);
          return Card(
            child: ListTile(
              title: Text("${currentStudentLogs[index].transactionAmount}"),
              subtitle: Text(formattedDateTime),
            ),
          );
        },
      );
    }

    return Column(children: [
      Expanded(child: content),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton.icon(
              onPressed: () {
                _onUndoLogTap(currentStudentLogs[0]
                    .logID); // to be done
              },
              label:const Text("Undo Log"),
              icon:const Icon(Icons.undo)),
          const SizedBox(width: 5),
          ElevatedButton.icon(
              onPressed: _onDeleteTap,
              label:const Text("Delete Student"),
              icon:const Icon(Icons.delete)),
        ],
      )
    ]);
  }
}
