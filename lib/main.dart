import 'package:flutter/material.dart';
import 'package:amaliy7/task_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Baza bilan ishlash',
      debugShowCheckedModeBanner: false,
      home:TaskListScreen(),
    );
  }
}