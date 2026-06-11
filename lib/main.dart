import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    ProviderScope(
      child: TodoPro()
    )
  );
}

class TodoPro extends StatelessWidget {
  const TodoPro({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo Pro',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Dashboard(title: 'Flutter Demo Home Page'),
    );
  }
}

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        
      ),
    );
  }
}