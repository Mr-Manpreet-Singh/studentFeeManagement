import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:feemanagement/screens/class__list.dart';

//  to Do

// - safe panel on Ui top
// edit student details edit logs
// structure code | Theming | Colors and UI

void main() async {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            color: Colors.black87,
            foregroundColor: Colors.white,
            centerTitle: true),
        listTileTheme: ListTileThemeData(
          tileColor: Colors.grey[200],
          textColor: Colors.black87,
          iconColor: Colors.red[800],
          
          titleTextStyle:
              const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          subtitleTextStyle:
              const TextStyle(fontSize: 15,),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          iconSize: 30,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          iconColor: Colors.black87,
          prefixIconColor: Colors.black87,
        ),
        primarySwatch: Colors.green,
      ),
      home: const SafeArea(child: ClassScreen()),
    );
  }
}
