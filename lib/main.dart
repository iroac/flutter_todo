import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:state_flutter/ui/home/widgets/todo_screen.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('mybox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoPage(),
      theme: ThemeData(primarySwatch: Colors.yellow),
    );
  }
}
