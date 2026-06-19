import 'package:freezed_annotation/freezed_annotation.dart';
part 'todo.freezed.dart';
part 'todo.g.dart';

@freezed
abstract class Todo with _$Todo {
    const factory Todo({
        required String title,
        required bool isDone,
        required int id
    }) = _Todo;

    factory Todo.fromJson(Map<String, Object?> json) => _$TodoFromJson(json);
}

// class Todo{
//   String title;
//   bool isDone;
//   int id;

//   Todo({
//     required this.title,
//     this.isDone = false,
//     required this.id
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       "title": title,
//       "isDone": isDone,
//       "id": id
//     };
//   }

//   Todo.fromJson(Map<String, dynamic> todoMap) 
//     : title = todoMap["title"],
//       isDone = todoMap["isDone"],
//       id = todoMap["id"];
// }