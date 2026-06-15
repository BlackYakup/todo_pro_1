import '../models/todo.dart';
import 'contracts/todo_storage.dart';

class JsonTodoStorage implements TodoStorage {
  final List<Todo> _todos = [
    Todo(id: 1, title: 'Flutter lernen', isDone: true),
    Todo(id: 2, title: 'Einkaufen gehen', isDone: false),
    Todo(id: 3, title: 'Projekt dokumentieren', isDone: true),
  ];

  @override
  Future<List<Todo>> loadTodos() async {
    return List.unmodifiable(_todos);
  }

  @override
  Future<List<Todo>> addTodo(Todo todo) async {
    _todos.add(todo);
    return List.unmodifiable(_todos);
  }

  @override
  Future<List<Todo>> deleteTodo(int id) async {
    _todos.removeWhere((todo) => todo.id == id);
    return List.unmodifiable(_todos);
  }

  @override
  Future<List<Todo>> updateTodo(Todo todo) async {
    final index = _todos.indexWhere((t) => t.id == todo.id);

    if (index != -1) {
      _todos[index] = todo;
    }

    return List.unmodifiable(_todos);
  }
}
