import '../models/todo.dart';
import 'todo_storage.dart';

class JsonTodoStorage implements TodoStorage{

  @override
  Future<List<Todo>> loadTodos(){
    return List[];
  }

  @override
  Future<void> addTodo(Todo todo){

  }

  @override
  Future<void> deleteTodo(int id){
    
  }

  @override
  Future<void> updateTodo(Todo todo){

  }
}
