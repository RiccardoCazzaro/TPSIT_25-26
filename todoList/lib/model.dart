import 'package:flutter/material.dart';
class Todo {
  Todo({required this.name, required this.checked, required this.controller});
  final TextEditingController controller;
  String name;
  bool checked;
}

class Note {
  Note({required this.title, required this.todos, required this.titleController});

  String title;
  List<Todo> todos;
  final TextEditingController titleController;
}
