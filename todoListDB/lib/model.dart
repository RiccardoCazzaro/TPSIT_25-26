import 'package:flutter/material.dart';

class Todo {
  int? id;
  final TextEditingController controller;
  String name;
  bool checked;

  Todo(
      {this.id,
      required this.name,
      required this.checked,
      required this.controller});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'checked': checked ? 1 : 0,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      name: map['name'],
      checked: map['checked'] == 1,
      controller: TextEditingController(text: map['name']),
    );
  }
}

class Note {
  Note(
      {this.id,
      required this.title,
      required this.todos,
      required this.titleController});
  int? id;
  String title;
  List<Todo> todos;
  final TextEditingController titleController;
}
