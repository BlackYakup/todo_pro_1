class Todo{
  String title;
  bool isDone;
  int id;

  Todo({
    required this.title,
    this.isDone = false,
    required this.id
  });

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "isDone": isDone,
      "id": id
    };
  }

  Todo.fromJson(Map<String, dynamic> todoMap) 
    : title = todoMap["title"],
      isDone = todoMap["isDone"],
      id = todoMap["id"];
}