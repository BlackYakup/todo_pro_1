import '../models/todo.dart';

abstract interface class TodoStorage {
  
  Future<List<Todo>> loadTodos();

  Future<void> addTodo(Todo todo);

  Future<void> deleteTodo(int id);

  Future<void> updateTodo(Todo todo);
}