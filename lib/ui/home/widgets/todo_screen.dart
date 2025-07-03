import 'package:flutter/material.dart';
import 'package:state_flutter/ui/core/themes/colors.dart';
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
            widget.viewModel.saveNewTask(_controller.text, 'Primeiro Grupo');
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    widget.viewModel.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        backgroundColor: AppColors.primary,
        child: Icon(Icons.add, color: AppColors.background),
      ),
      body: ListenableBuilder(
        listenable: widget.viewModel,
        builder: (context, child) {
          return ListView.builder(
            itemCount: widget.viewModel.toDoGroups.length,
            itemBuilder: (context, index) {
              final currentGroup = widget.viewModel.toDoGroups[index].groupName;
              return Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text(
                        currentGroup,
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                          widget.viewModel.toDoGroups[index].todoList.length,
                      itemBuilder: (context, iItem) {
                        final task =
                            widget.viewModel.toDoGroups[index].todoList[iItem];
                        return TodoTile(
                          taskName: task[0],
                          taskCompleted: task[1],
                          onChanged: (val) => widget.viewModel.checkBoxChanged(
                            val,
                            iItem,
                            currentGroup,
                          ),
                          handleDelete: (context) => widget.viewModel
                              .checkBoxDelete(iItem, currentGroup),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
