import 'package:hive/hive.dart';
import 'package:flutter/foundation.dart';
import 'package:state_flutter/data/repositories/todo/database.dart';

class TodoViewModel extends ChangeNotifier {
  TodoViewModel({required TodoDataBase db}) : _db = db {
    toDoList = _db.toDoList;
  }

  final TodoDataBase _db;
  final _myBox = Hive.box('mybox');
  List<dynamic> toDoList = [];

  Future<void> checkBoxChanged(bool? value, int index) async {
    try {
      _db.toDoList[index][1] = value;
      await _db.updateDataBase();
    } finally {
      toDoList = _db.toDoList;
      notifyListeners();
    }
  }

  Future<void> checkBoxDelete(int index) async {
    try {
      _db.toDoList.removeAt(index);
      await _db.updateDataBase();
    } finally {
      toDoList = _db.toDoList;
      notifyListeners();
    }
  }

  Future<void> saveNewTask(String text) async {
    try {
      _db.toDoList.add([text, false]);
      text = "";
      await _db.updateDataBase();
    } finally {
      notifyListeners();
    }
  }

  void load() {
    if (_myBox.get("TODOLIST") == null) {
      _db.createInitialData();
      toDoList = _db.toDoList;
    } else {
      _db.loadData();
      toDoList = _db.toDoList;
    }
  }
}
