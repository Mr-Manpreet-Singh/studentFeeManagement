import 'package:feemanagement/models/student_model.dart';
import 'package:feemanagement/providers/class_provider.dart';
import 'package:feemanagement/providers/student_provider.dart';
import 'package:flutter/material.dart';
// import 'package:feemanagement/dummy_data/dummy_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddStudent extends ConsumerStatefulWidget {
  const AddStudent({super.key, required this.currentClass});
  final String currentClass;

  @override
  ConsumerState<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends ConsumerState<AddStudent> {
  String studentName = "";
  String studentClass = "";
  int fee = -1;

  final _formKey = GlobalKey<FormState>();

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      ref.read(studentsProvider.notifier).addStudent(
          Student(name: studentName, fee: fee, studentClass: studentClass));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title:const Text("Add New Student"),),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                      hintText: "Name", prefixIcon: Icon(Icons.person)),
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter Valid input";
                    }
                    return null;
                  },
                  onSaved: (newValue) => studentName = newValue!,
                ),
                const SizedBox(height: 15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                            hintText: "Fee",
                            prefixIcon: Icon(Icons.currency_rupee)),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter the valid input";
                          }
                          final inputFee = int.tryParse(value);
                          if (inputFee == null) return "Enter the valid input";
                          return null;
                        },
                        onSaved: (newValue) => fee = int.parse(newValue!),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: DropdownButtonFormField(
                        value: widget.currentClass,
                        onChanged: (_) {},
                        items: buildDropdownItems(ref),
                        validator: (value) {
                          if (value == null || value.isEmpty) return " Error";
                          return null;
                        },
                        onSaved: (newValue) => studentClass = newValue!,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextButton(
                            onPressed: () {
                              _formKey.currentState!.reset();
                            },
                            child: const Text(
                              "  Reset  ",
                            ))),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ElevatedButton(
                            onPressed: _onSubmit, child: const Text("+ Add"))),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}

List<DropdownMenuItem<String>> buildDropdownItems(WidgetRef ref) {
  List<DropdownMenuItem<String>> items = [];
  final classesList = ref.read(studentClassProvider);
  for (String option in classesList) {
    items.add(
      DropdownMenuItem<String>(
        value: option,
        child: Text(option), // customize child as per the requirnment
      ),
    );
  }

  return items;
}
