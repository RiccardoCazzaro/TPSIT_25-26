class Todo {
  Todo({required this.name, required this.checked});

  String name;
  bool checked;
}

class Note {
  Note({required this.title, required this.todos});

  String title;
  List<Todo> todos;
}
