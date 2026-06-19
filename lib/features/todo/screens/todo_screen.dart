import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/todo.dart';
import '../providers/todo_providers.dart';

class TodoScreen extends ConsumerStatefulWidget {
  const TodoScreen({super.key});

  @override
  ConsumerState<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends ConsumerState<TodoScreen> {
  final _titleController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _addTodo() async {
    final title = _titleController.text.trim();

    if (title.isEmpty) {
      return;
    }

    final todo = Todo(
      id: DateTime.now().microsecondsSinceEpoch,
      title: title,
      isDone: false,
    );

    await ref.read(todoNotifierProvider.notifier).addTodo(todo);
    _titleController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final todos = ref.watch(todoNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Todo Pro')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Neue Aufgabe',
                    ),
                    onSubmitted: (_) => _addTodo(),
                  ),
                ),
                const SizedBox(width: 12),
                FilledButton(
                  onPressed: _addTodo,
                  child: const Text('Hinzufügen'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: todos.when(
                data: (todos) {
                  if (todos.isEmpty) {
                    return const Center(
                      child: Text('Noch keine Aufgaben vorhanden.'),
                    );
                  }

                  return ListView.separated(
                    itemCount: todos.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final todo = todos[index];

                      return ListTile(
                        leading: Checkbox(
                          value: todo.isDone,
                          onChanged: (isDone) {
                            ref
                                .read(todoNotifierProvider.notifier)
                                .updateTodo(
                                  todo.copyWith(isDone: isDone ?? false),
                                );
                          },
                        ),
                        title: Text(
                          todo.title,
                          style: TextStyle(
                            decoration: todo.isDone
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline),
                          tooltip: 'Loeschen',
                          onPressed: () {
                            ref
                                .read(todoNotifierProvider.notifier)
                                .deleteTodo(todo.id);
                          },
                        ),
                      );
                    },
                  );
                },
                error: (error, stackTrace) =>
                    Center(child: Text('Fehler beim Laden: $error')),
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
