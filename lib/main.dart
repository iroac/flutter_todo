import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:state_flutter/data/repositories/todo/database.dart';
import 'package:state_flutter/ui/home/view_models/todo_viewmodel.dart';
import 'package:state_flutter/ui/home/widgets/todo_screen.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('mybox');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final viewModel = TodoViewModel(db: TodoDataBase());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoScreen(viewModel: viewModel),
      theme: ThemeData(primarySwatch: Colors.yellow),
    );
  }
}
