import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_pro/features/todo/models/todo.dart';
import 'package:todo_pro/features/todo/storage/db_todo_storage.dart';
import 'package:todo_pro/features/todo/storage/todo_storage.dart';

final todoStorageProvider = Provider<TodoStorage>((ref) {
  return DbTodoStorage();
});

final todoNotifierProvider = AsyncNotifierProvider<TodoNotifier, List<Todo>>(TodoNotifier.new);

class TodoNotifier extends AsyncNotifier<List<Todo>> {
  late final TodoStorage _storage;

  @override
  Future<List<Todo>> build() async {
    _storage = ref.read(todoStorageProvider);
    return _storage.loadTodos();
  }

  Future<void> addTodo(Todo todo) async {
    state = const AsyncValue.loading();
    final newTodos = await _storage.addTodo(todo);
    state = AsyncValue.data(newTodos);
  }

  Future<void> deleteTodo(int id) async {
    state = const AsyncValue.loading();
    final newTodos = await _storage.deleteTodo(id);
    state = AsyncValue.data(newTodos);
  }

  Future<void> updateTodo(Todo todo) async {
    state = const AsyncValue.loading();
    final newTodos = await _storage.updateTodo(todo);
    state = AsyncValue.data(newTodos);
  }

  Future<void> updateTodoTitle(Todo todo, String title) async {
    state = const AsyncValue.loading();
    final newTodo = todo.copyWith(title: title);
    final newTodos = await _storage.updateTodo(newTodo);
    state = AsyncValue.data(newTodos);
  }
}
