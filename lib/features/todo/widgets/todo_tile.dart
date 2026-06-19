import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_pro/features/todo/models/todo.dart';
import 'package:todo_pro/features/todo/providers/todo_providers.dart';

class TodoTile extends ConsumerWidget {
  const TodoTile({super.key, required this.todo});

  final Todo todo;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: Checkbox(
        value: todo.isDone,
        onChanged: (isDone) {
          ref.read(todoNotifierProvider.notifier).updateTodo(todo.copyWith(isDone: isDone ?? false));
        },
      ),
      title: Text(todo.title, style: TextStyle(decoration: todo.isDone ? TextDecoration.lineThrough : null)),
      trailing: SizedBox(
        width: 96,
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.edit_outlined),
              tooltip: 'Bearbeiten',
              onPressed: () {
                _showEditDialog(context, ref);
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline),
              tooltip: 'Löschen',
              onPressed: () {
                ref.read(todoNotifierProvider.notifier).deleteTodo(todo.id);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> _showEditDialog(BuildContext context, WidgetRef ref) {
    return showDialog(
      context: context,
      builder: (context) {
        final titleController = TextEditingController(text: todo.title);

        return AlertDialog(
          title: const Text('Aufgabe bearbeiten'),
          content: TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Titel'),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Abbrechen')),
            ElevatedButton(
              onPressed: () {
                final newTitle = titleController.text.trim();
                if (newTitle.isNotEmpty) {
                  ref.read(todoNotifierProvider.notifier).updateTodoTitle(todo, newTitle);
                }
                Navigator.pop(context);
              },
              child: const Text('Speichern'),
            ),
          ],
        );
      },
    );
  }
}
