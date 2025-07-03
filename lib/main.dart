import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:state_flutter/data/repositories/todo/database.dart';
import 'package:state_flutter/models/todo_model.dart';
import 'package:state_flutter/ui/core/themes/colors.dart';
import 'package:state_flutter/ui/history/history_screen.dart';
import 'package:state_flutter/ui/home/view_models/todo_viewmodel.dart';
import 'package:state_flutter/ui/home/widgets/todo_screen.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ToDoGroupAdapter());
  await Hive.openBox('mybox');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyNavigationBottom(),
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}

class MyNavigationBottom extends StatefulWidget {
  const MyNavigationBottom({super.key});

  @override
  State<MyNavigationBottom> createState() => _MyNavigationBottomState();
}

class _MyNavigationBottomState extends State<MyNavigationBottom> {
  int currentPageIndex = 0;

  final viewModelHome = TodoViewModel(db: TodoDataBase());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        indicatorColor: Colors.red[200],
        backgroundColor: AppColors.primary,
        labelTextStyle: WidgetStateProperty.all(TextStyle(color: Colors.white)),
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home, color: AppColors.background),
            icon: Icon(Icons.home_outlined, color: AppColors.background),
            label: 'Tasks',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.check_circle, color: AppColors.background),
            icon: Badge(
              child: Icon(
                Icons.check_circle_outline,
                color: AppColors.background,
              ),
            ),
            label: 'Done Tasks',
          ),
        ],
      ),
      body: <Widget>[
        TodoScreen(viewModel: viewModelHome),
        HistoryScreen(viewModel: viewModelHome),
      ][currentPageIndex],
    );
  }
}
