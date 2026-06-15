import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_pro/logic/models/todo.dart';
import 'package:todo_pro/logic/providers/todo_storage_provider.dart';
import 'package:todo_pro/logic/storage/contracts/todo_storage.dart';

final appStateProvider = AsyncNotifierProvider<TodoJsonNotifier, List<Todo>>(TodoJsonNotifier.new);

class TodoJsonNotifier extends AsyncNotifier<List<Todo>> {
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

  Future<void> updateTodoTitle(Todo todo, String newTitle) async {
    state = const AsyncValue.loading();
    final newTodo = todo.copyWith(title: newTitle);
    final newTodos = await _storage.updateTodo(newTodo);
    state = AsyncValue.data(newTodos);
  }

  Future<void> toggleStatus(Todo todo) async {
    state = AsyncValue.loading();
    final newTodo = todo.copyWith(isDone: !todo.isDone);
    final newTodos = await _storage.updateTodo(newTodo);
    state = AsyncValue.data(newTodos);
  }
}
