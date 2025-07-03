import 'package:hive_flutter/hive_flutter.dart';
import 'package:state_flutter/models/todo_model.dart';

class TodoDataBase {
  List<ToDoGroup> toDoGroups = [];

  // reference our box
  final _myBox = Hive.box('mybox');

  createInitialData() {
    toDoGroups = [
      ToDoGroup(
        groupName: 'Primeiro Grupo',
        todoList: [
          ['Make Tutorial', false],
          ['Do Exercise', false],
        ],
      ),
    ];
  }

  loadData() {
    toDoGroups = _myBox.get("TODOGROUPS");
  }

  Future<void> updateDataBase() {
    return _myBox.put('TODOGROUPS', toDoGroups);
  }
}
