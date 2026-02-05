import 'package:flutter/widgets.dart';
import 'model.dart';
import 'db.dart';

class TodoListNotifier with ChangeNotifier {
   List<Note> _notes = [];
  int get length => _notes.length;

  Future<void> loadFromDb() async {
    final notesMap = await DatabaseHelper.getNotes();
    List<Note> tempNotes = [];
    for (var n in notesMap) {
      final todos = await DatabaseHelper.getTodos(n['id']);
      tempNotes.add(Note(
          id: n['id'],
          title: n['title'],
          todos: todos,
          titleController: TextEditingController(text: n['title'])));
    }
    _notes = tempNotes;
    notifyListeners();
  }

  void addNote(String title) async {
      final id = await DatabaseHelper.insertNote(title);
    _notes.add(Note(
              id: id, title: title, todos: [], titleController: TextEditingController(text: title)));
    notifyListeners();
  }


  void addTodoToNote(int noteIndex, String name) async {
    Todo newTodo = Todo(
        name: name,
        checked: false,
        controller: TextEditingController(text: name));
    await DatabaseHelper.insertTodo(newTodo, _notes[noteIndex].id!);
    _notes[noteIndex].todos.add(newTodo);
   notifyListeners();
  }

  void updateTodo(int noteIndex, Todo todo, String newName) async {
    todo.name = newName;
    await DatabaseHelper.updateTodo(todo);
  }

  void changeTodoStatus(int noteIndex, Todo todo) async {
    todo.checked = !todo.checked;
    await DatabaseHelper.updateTodo(todo);
    notifyListeners();
  }

  void deleteTodo(int noteIndex, Todo todo) async {
    await DatabaseHelper.deleteTodo(todo.id!);
    _notes[noteIndex].todos.remove(todo);
    notifyListeners();
  }

  void deleteNote(int noteIndex) async {
    final note = _notes[noteIndex];
    if (note.id != null) {
      await DatabaseHelper.deleteNote(note.id!);
      _notes.removeAt(noteIndex);
      notifyListeners();
    }
  }

  void updateNoteTitle(Note note, String newTitle) async {
    note.title = newTitle;
    await DatabaseHelper.updateNoteTitle(note, newTitle); 
  }

  Note getNote(int index) {
    return _notes[index];
  }
}
