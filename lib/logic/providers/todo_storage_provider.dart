import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_pro/logic/storage/json_todo_storage.dart';
import 'package:todo_pro/logic/storage/contracts/todo_storage.dart';

final todoStorageProvider = Provider<TodoStorage>((ref) {
  return JsonTodoStorage();
});
