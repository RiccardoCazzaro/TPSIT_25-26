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
            title: Text(note.title),
          ),
          Column(
            children: [
              for (int i = 0; i < note.todos.length; i++)
                TodoItem(
                    todo: note.todos[i], noteIndex: noteIndex, todoIndex: i),
              if (note.todos.length < 3)
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    notifier.addTodoToNote(noteIndex, "Nuovo Todo");
                  },
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
      {required this.todo, required this.noteIndex, required this.todoIndex})
      : super(key: ObjectKey(todo));

  final Todo todo;
  final int noteIndex;
  final int todoIndex;

  @override
  Widget build(BuildContext context) {
    final notifier = context.read<TodoListNotifier>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              initialValue: todo.name,
              onChanged: (text) {
                notifier.updateTodo(noteIndex, todo, text);
              },
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Scrivi qua",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
