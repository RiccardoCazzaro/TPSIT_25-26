import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model.dart';
import 'notifier.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({super.key, required this.note, required this.noteIndex});
  final Note note;
  final int noteIndex;

  @override
  Widget build(BuildContext context) {
    final notifier = context.read<TodoListNotifier>();
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          ListTile(
            title: TextField(
              controller: note.titleController, 
              onChanged: (text) {
                note.title = text;
              },
              decoration: const InputDecoration(
                hintText: "Titolo nota",
                border: InputBorder.none,
              ),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          Column(
            children: [
              for (int i = 0; i < note.todos.length; i++)
                TodoItem(
                    todo: note.todos[i], noteIndex: noteIndex),
              Row(
                   children: [
                IconButton(
                  icon: const Icon(Icons.add),
                  tooltip: "Aggiungi todo",
                  onPressed: () {
                    notifier.addTodoToNote(noteIndex, "Nuovo Todo");
                  },
                ),
               IconButton(
                  icon: const Icon(Icons.delete),
                  tooltip: "Elimina nota",
                  onPressed: () {
                    notifier.deleteNote(noteIndex);
                  },
                ),
                   ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TodoItem extends StatelessWidget {
  TodoItem(
      {required this.todo, required this.noteIndex})
      : super(key: ObjectKey(todo));

  final Todo todo;
  final int noteIndex;

  TextStyle? _getTextStyle(bool checked) {
    if (!checked) return null;
    return const TextStyle(
      color: Colors.black,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    final notifier = context.read<TodoListNotifier>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Checkbox(
            value: todo.checked,
            onChanged: (bool? value) {
              notifier.changeTodoStatus(noteIndex, todo);
            },
          ),
          Expanded(
            child: TextField(
              controller: todo.controller, 
              onChanged: (text) {
                notifier.updateTodo(noteIndex, todo, text);
              },
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Scrivi qua",
              ),
               style: _getTextStyle(todo.checked),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, size: 20),
            onPressed: () => notifier.deleteTodoFromNote(noteIndex, todo), 
          ),
        ],
      ),
    );
  }
}
