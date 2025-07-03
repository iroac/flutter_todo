import 'package:flutter/material.dart';
import 'package:state_flutter/ui/core/themes/colors.dart';
import 'package:state_flutter/ui/home/view_models/todo_viewmodel.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key, required this.viewModel});

  final TodoViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final completedTasks = [
      for (var g in viewModel.toDoGroups)
        ...g.todoList.where((item) => item[1]),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Histórico de Tarefas'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: completedTasks.isEmpty
            ? const Center(
                child: Text(
                  'Nenhuma tarefa concluída ainda.',
                  style: TextStyle(fontSize: 16),
                ),
              )
            : ListView.separated(
                itemCount: completedTasks.length,
                itemBuilder: (context, index) {
                  final task = completedTasks[index][0];
                  return ListTile(
                    leading: const Icon(
                      Icons.check_circle,
                      color: AppColors.primary,
                    ),
                    title: Text(
                      task,
                      style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              ),
      ),
    );
  }
}
