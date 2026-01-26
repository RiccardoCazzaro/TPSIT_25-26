import 'package:flutter/widgets.dart';
import 'model.dart';

class TodoListNotifier with ChangeNotifier {
  final List<Note> _notes = [];

  int get length => _notes.length;

  void addNote(String title) {
    _notes.add(Note(title: title, todos: []));
    notifyListeners();
  }

  void addTodoToNote(int noteIndex, String name) {
    _notes[noteIndex].todos.add(Todo(name: name, checked: false));
    notifyListeners();
  }

  void updateTodo(int noteIndex, Todo todo, String newName) {
    todo.name = newName;
    notifyListeners();
  }

  void changeTodoStatus(int noteIndex, Todo todo) {
    todo.checked = !todo.checked;
    notifyListeners();
  }

  void deleteTodoFromNote(int noteIndex, Todo todo) {
    _notes[noteIndex].todos.remove(todo);
    notifyListeners();
  }

  Note getNote(int index) => _notes[index];

  Todo getTodoFromNote(int noteIndex, int todoIndex) =>
      _notes[noteIndex].todos[todoIndex];
}
