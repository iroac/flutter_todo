import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:state_flutter/ui/core/ui/dialog_box.dart';
import 'package:state_flutter/ui/core/ui/todo_tile.dart';
import 'package:state_flutter/ui/home/view_models/todo_viewmodel.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key, required this.viewModel});

  final TodoViewModel viewModel;

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final _controller = TextEditingController();

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onCancel: () => Navigator.of(context).pop(),
          onSave: () {
            widget.viewModel.saveNewTask(_controller.text);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  @override
  void didUpdateWidget(covariant TodoScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    log('update screen');
  }

  @override
  void initState() {
    super.initState();
    widget.viewModel.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Center(child: Text('TO DO')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        backgroundColor: Colors.yellow,
        child: Icon(Icons.add, color: Colors.black),
      ),
      body: ListenableBuilder(
        listenable: widget.viewModel,
        builder: (context, _) {
          return ListView.builder(
            itemCount: widget.viewModel.toDoList.length,
            itemBuilder: (context, index) {
              return TodoTile(
                taskName: widget.viewModel.toDoList[index][0],
                taskCompleted: widget.viewModel.toDoList[index][1],
                onChanged: (value) =>
                    widget.viewModel.checkBoxChanged(value, index),
                handleDelete: (context) =>
                    widget.viewModel.checkBoxDelete(index),
              );
            },
          );
        },
      ),
    );
  }
}
