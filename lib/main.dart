import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_pro/gui/dashboard_screed/dashboard_screen.dart';

void main() {
  runApp(ProviderScope(child: TodoPro()));
}

class TodoPro extends StatelessWidget {
  const TodoPro({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo Pro',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const DashboardScreen(),
    );
  }
}
