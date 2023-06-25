import 'package:uuid/uuid.dart';
const uuid =  Uuid();

class Student {
   Student({required this.name,required this.fee, required this.studentClass}) : id = uuid.v4() , regesteredDate = DateTime.now();
  final String name;
  final String studentClass;
  final int fee;
  final String id;
  final DateTime regesteredDate;
}
