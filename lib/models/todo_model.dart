import 'package:hive/hive.dart';
part 'todo_model.g.dart';

@HiveType(typeId: 0)
class TodoItem {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final bool done;

  @HiveField(3)
  TodoItem(this.title, this.done);
}

@HiveType(typeId: 1)
class ToDoGroup {
  @HiveField(4)
  final String groupName;

  @HiveField(5)
  final List<List<dynamic>> todoList;

  @HiveField(6)
  ToDoGroup({required this.groupName, List<List<dynamic>>? todoList})
    : todoList = todoList ?? [];

  @HiveField(7)
  bool isExpanded = false;
}
