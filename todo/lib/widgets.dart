import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model.dart';
import 'notifier.dart';

class TodoItem extends StatelessWidget {
  TodoItem({required this.todo}) : super(key: ObjectKey(todo));

  final Todo todo;
  final TextEditingController todoController = TextEditingController();

  TextStyle? _getTextStyle(bool checked) {
    if (!checked) return null;
    return const TextStyle(
      color: Colors.black,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    final TodoListNotifier notifier = context.read<TodoListNotifier>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Checkbox(
            value: todo.checked,
            onChanged: (bool? value) {
              notifier.changeTodo(todo);
            },
          ),
          Expanded(
            child: TextField(
              controller: todoController,
              onChanged: (text) => notifier.updateTodo(todo, text),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Nota...",
              ),
              style: _getTextStyle(todo.checked),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, size: 20),
            onPressed: () => notifier.deleteTodo(todo),
          ),
        ],
      ),
    );
  }
}
