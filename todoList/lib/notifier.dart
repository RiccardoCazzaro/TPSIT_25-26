import 'package:flutter/widgets.dart';
import 'model.dart';

class TodoListNotifier with ChangeNotifier {
  final List<Note> _notes = [];

  int get length => _notes.length;

  void addNote(String title) {
    _notes.add(Note(title: title, todos: [], titleController: TextEditingController()));
    notifyListeners();
  }

  void addTodoToNote(int noteIndex, String name) {
    _notes[noteIndex].todos.add(Todo(name: name, checked: false, controller: TextEditingController()));
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

  Note getNote(int index) {
    return _notes[index];
  }
}