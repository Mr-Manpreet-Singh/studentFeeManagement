import 'package:uuid/uuid.dart';

const uuid = Uuid();

class FeeLog {
  FeeLog(
      {required this.feePaidDate,
      required this.transactionAmount,
      required this.studentId,
      String? id}) : logID = id?? uuid.v4();
  final DateTime feePaidDate;
  final int transactionAmount;
  final String studentId;
  final String logID;

  
}

class Student {
  Student(
      {required this.name,
      required this.totalFee,
      required this.alreadyFeePaid,
      required this.studentClass,
      String? id,
      DateTime? registeredDate})
      : id = id ?? uuid.v4(),
        registeredDate = registeredDate ?? DateTime.now();

  final String name;
  final String studentClass;
  final int totalFee;
  final int alreadyFeePaid;
  final String id;
  final DateTime registeredDate;

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

// class Student {
//   Student({
//     required this.name,
//     required this.totalFee,
//     required this.alreadyFeePaid,
//     required this.studentClass,
//     String? id,
//     DateTime? registeredDate,
//   })  : id = id ?? Uuid().v4(),
//         registeredDate = registeredDate ?? DateTime.now();

//   final String name;
//   final String studentClass;
//   final int totalFee;
//   final int alreadyFeePaid;
//   final String id;
//   final DateTime registeredDate;

//   Student copyWith({
//     String? name,
//     String? studentClass,
//     int? totalFee,
//     int? alreadyFeePaid,
//     DateTime? registeredDate,
//     String? id,
//   }) {
//     return Student(
//       name: name ?? this.name,
//       studentClass: studentClass ?? this.studentClass,
//       totalFee: totalFee ?? this.totalFee,
//       alreadyFeePaid: alreadyFeePaid ?? this.alreadyFeePaid,
//       id: id ?? this.id,
//       registeredDate: registeredDate ?? this.registeredDate,
//     );
//   }
// }
