// import 'package:sqflite/sqflite.dart' as sql;
// import 'package:sqflite/sqlite_api.dart';
// import 'package:sqflite_common_ffi/sqflite_ffi.dart' as sqflite_ffi;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:feemanagement/screens/class__list.dart';
// import 'package:sqflite_common_ffi/sqflite_ffi.dart';


//  to Do 
// - search bar
// - safe panel on Ui top 
// edit student details edit logs ...
// structure code | Theming | Colors and UI

void main() async{
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
   const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return   const MaterialApp(
      // theme: ThemeData(brx`ightness: Brightness.dark),
      home: SafeArea(child: ClassScreen()),
      // home: SafeArea(child: StudentDetails())
    );
  }
}

