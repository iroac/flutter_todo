import 'package:hive_flutter/hive_flutter.dart';

class TodoDataBase {
  List toDoList = [];

  // reference our box
  final _myBox = Hive.box('mybox');

  createInitialData() {
    toDoList = [
      ['Make Tutorial', false],
      ['Do Exercise', false],
    ];
  }

  loadData() {
    toDoList = _myBox.get("TODOLIST");
  }

  Future<void> updateDataBase() {
    return _myBox.put('TODOLIST', toDoList);
  }
}
