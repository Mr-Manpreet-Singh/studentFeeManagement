// import 'package:feemanagement/dummy_data/dummy_data.dart';
import 'package:feemanagement/providers/class_provider.dart';
import 'package:feemanagement/screens/student_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:feemanagement/widgets/floating_button.dart';

class ClassScreen extends ConsumerStatefulWidget {
  const ClassScreen({super.key});

  @override
  ConsumerState<ClassScreen> createState() => _ClassScreenState();
}

class _ClassScreenState extends ConsumerState<ClassScreen> {
  void _onClassTap(BuildContext context, String className) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => StudentList(currentClass: className),
    ));
  }

  void _onSubmit(String inputClasss) {
    if (inputClasss.isNotEmpty) {
      ref.read(studentClassProvider.notifier).addClassToList(inputClasss);
      Navigator.of(context).pop();
      // Navigator.of(context).pushReplacement(MaterialPageRoute(
      //     builder: (context) => ClassScreen()));
    }
  }

  void _addClass(context, WidgetRef ref) async {
    final newClassController = TextEditingController();
    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                autofocus: true,
                onSubmitted: (value) {
                  _onSubmit(value);
                },
                controller: newClassController,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.group), hintText: "Class Name.."),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                  onPressed: () {
                    _onSubmit(newClassController.text);
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Add Class"))
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<String> classesList = ref.watch(studentClassProvider);
    return Scaffold(
      appBar: AppBar(title:const Text("Batches"),),
      body: ListView.builder(
        itemCount: classesList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () {
                _onClassTap(context, classesList[index]);
              },
              title: Text(classesList[index]), //error in this line
              //  subtitle: Text("Status : pending/ Paid"), in student list
              trailing: IconButton.filled(
                  onPressed: () {
                    ref.read(studentClassProvider.notifier).removeClassfromList(
                        classesList[index]); //error in this line
                  },
                  icon: const Icon(Icons.delete)),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addClass(context, ref);
        },
        child: const Icon(Icons.group_add),
      ),
    );
  }
}
