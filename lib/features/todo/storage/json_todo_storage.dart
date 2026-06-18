import '../models/todo.dart';
import 'todo_storage.dart';

class JsonTodoStorage implements TodoStorage{

  @override
  Future<List<Todo>> loadTodos(){
    return Future.value([]);
  }

  @override
  Future<List<Todo>> addTodo(Todo todo){
    return Future.value([todo]);
  }

  @override
  Future<List<Todo>> deleteTodo(int id){
    return Future.value([]);
  }

  @override
  Future<List<Todo>> updateTodo(Todo todo){
    return Future.value([todo]);
  }
}
