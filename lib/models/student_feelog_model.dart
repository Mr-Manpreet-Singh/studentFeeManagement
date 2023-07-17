import 'package:uuid/uuid.dart';

const uuid = Uuid();

class FeeLog {
  FeeLog(
      {
      String? id,
      required this.studentId,
        required this.feePaidDate,
      required this.transactionAmount,
      }) : logID = id?? uuid.v4();
  final String logID;
  final String studentId;
  final DateTime feePaidDate;
  final int transactionAmount;

  
}

class Student {
  Student(
      {
      String? id,
      DateTime? registeredDate,
        required this.name,
      required this.studentClass,
      required this.totalFee,
      required this.alreadyFeePaid,
      })
      : id = id ?? uuid.v4(),
        registeredDate = registeredDate ?? DateTime.now();

  final String id;
  final DateTime registeredDate;
  final String name;
  final String studentClass;
  final int totalFee;
  final int alreadyFeePaid;

  Student copyWith(
      {String? name,
      String? studentClass,
      int? totalFee,
      int? alreadyFeePaid,
      DateTime? registeredDate,
      String? id}) {
    return Student(
        name: name ?? this.name,
        studentClass: studentClass ?? this.studentClass,
        totalFee: totalFee ?? this.totalFee,
        alreadyFeePaid: alreadyFeePaid ?? this.alreadyFeePaid,
        registeredDate: registeredDate ?? this.registeredDate,
        id: id ?? this.id);
  }
}
