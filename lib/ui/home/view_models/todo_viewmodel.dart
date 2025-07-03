import 'package:hive/hive.dart';
import 'package:flutter/foundation.dart';
import 'package:state_flutter/data/repositories/todo/database.dart';
import 'package:state_flutter/models/todo_model.dart';

class TodoViewModel extends ChangeNotifier {
  TodoViewModel({required TodoDataBase db}) : _db = db {
    toDoGroups = _db.toDoGroups;
  }

  final TodoDataBase _db;
  final _myBox = Hive.box('mybox');
  List<ToDoGroup> toDoGroups = [];

  Future<void> checkBoxChanged(bool? value, int index, String groupName) async {
    try {
      final group = _db.toDoGroups.firstWhere(
        (g) => g.groupName == groupName,
        orElse: () => throw Exception('Group "$groupName" not found'),
      );

      group.todoList[index][1] = value;
      await _db.updateDataBase();
    } finally {
      toDoGroups = _db.toDoGroups;
      notifyListeners();
    }
  }

  Future<void> checkBoxDelete(int index, String groupName) async {
    try {
      final group = _db.toDoGroups.firstWhere(
        (g) => g.groupName == groupName,
        orElse: () => throw Exception('Group "$groupName" not found'),
      );

      group.todoList.removeAt(index);
      await _db.updateDataBase();
    } finally {
      toDoGroups = _db.toDoGroups;
      notifyListeners();
    }
  }

  Future<void> saveNewTask(String groupName, String text) async {
    try {
      final group = _db.toDoGroups.firstWhere(
        (g) => g.groupName == groupName,
        orElse: () => throw Exception('Group "$groupName" not found'),
      );

      group.todoList.add([text, false]);

      text = "";
      await _db.updateDataBase();
    } finally {
      notifyListeners();
    }
  }

  void load() {
    if (_myBox.get("TODOGROUPS") == null) {
      _db.createInitialData();
      toDoGroups = _db.toDoGroups;
    } else {
      _db.loadData();
      toDoGroups = _db.toDoGroups;
    }
  }
}
