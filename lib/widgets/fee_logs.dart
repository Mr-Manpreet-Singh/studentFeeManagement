import 'package:feemanagement/dummy_data/dummy_data.dart';
import 'package:feemanagement/models/student_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
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
  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text("No Logs Found"),
    );
    final allLogs = ref.watch(feeLogsProvider);

    // debugPrint("${allLogs[0].studentId}  studn ID of_Log :");
    // debugPrint("${widget.studentId}   st ID recieverd ");

    if (allLogs.isNotEmpty) {
      final List<FeeLog> currentStudentLogs = allLogs
          .where((element) => element.studentId == widget.studentId)
          .toList();

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
    }

    return content;
  }
}
