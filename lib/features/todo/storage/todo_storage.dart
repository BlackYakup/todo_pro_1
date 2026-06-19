import 'package:todo_pro/features/todo/models/todo.dart';

abstract interface class TodoStorage {
  Future<List<Todo>> loadTodos();

  Future<List<Todo>> addTodo(Todo todo);

  Future<List<Todo>> deleteTodo(int id);

  Future<List<Todo>> updateTodo(Todo todo);
}
