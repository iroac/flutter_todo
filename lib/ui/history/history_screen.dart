import 'package:flutter/material.dart';
import 'package:state_flutter/ui/core/themes/colors.dart';
import 'package:state_flutter/ui/home/view_models/todo_viewmodel.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key, required this.viewModel});

  final TodoViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final completedTasks = viewModel.toDoList
        .where((task) => task[1] == true)
        .toList();

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
            : ListView.builder(
                itemCount: completedTasks.length,
                itemBuilder: (context, index) {
                  final task = completedTasks[index];
                  return ListTile(
                    leading: const Icon(
                      Icons.check_circle,
                      color: Color.fromARGB(255, 175, 76, 76),
                    ),
                    title: Text(
                      task[0],
                      style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
