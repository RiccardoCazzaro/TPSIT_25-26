import 'package:flutter/widgets.dart';
import 'model.dart';
import 'db.dart';

class TodoListNotifier with ChangeNotifier {
  final List<Note> _notes = [];
  int get length => _notes.length;

  Future<void> loadFromDb() async {
    final todos = await DatabaseHelper.getTodos();
    if (_notes.isEmpty) {
      _notes.add(Note(
          title: "I miei Todo",
          todos: todos,
          titleController: TextEditingController(text: "I miei Todo")));
    } else {
      _notes[0].todos = todos;
    }
    notifyListeners();
  }

  void addNote(String title) {
    _notes.add(Note(
        title: title, todos: [], titleController: TextEditingController()));
    notifyListeners();
  }

  void addTodoToNote(int noteIndex, String name) async {
    Todo newTodo = Todo(
        name: name,
        checked: false,
        controller: TextEditingController(text: name));
    await DatabaseHelper.insertTodo(newTodo);
    await loadFromDb(); // Ricarica per avere l'ID corretto dal DB
  }

  void updateTodo(int noteIndex, Todo todo, String newName) async {
    todo.name = newName;
    await DatabaseHelper.updateTodo(todo);
    notifyListeners();
  }

  void changeTodoStatus(int noteIndex, Todo todo) async {
    todo.checked = !todo.checked;
    await DatabaseHelper.updateTodo(todo);
    notifyListeners();
  }

  void deleteTodoFromNote(int noteIndex, Todo todo) async {
    await DatabaseHelper.deleteTodo(todo);
    _notes[noteIndex].todos.remove(todo);
    notifyListeners();
  }

  Note getNote(int index) {
    return _notes[index];
  }
}
