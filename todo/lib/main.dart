import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model.dart';
import 'notifier.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'todo list', // campo pernuovo todo

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      ),
      home: ChangeNotifierProvider<TodoListNotifier>(
        create: (notifier) => TodoListNotifier(),
        child: const MyHomePage(title: 'todo list'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _newTodoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final TodoListNotifier notifier = context.watch<TodoListNotifier>();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: notifier.length,
              itemBuilder: (context, index) {
                Todo todo = notifier.getTodo(index);

                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        Checkbox(
                          value: todo.isDone,
                          onChanged: (value) {
                            notifier.toggleTodoDone(index);
                          },
                        ),
                        Expanded(
                          child: TextFormField(
                            initialValue: todo.text,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            onFieldSubmitted: (newText) {
                              notifier.updateTodoText(index, newText);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _newTodoController,
                    decoration:
                        const InputDecoration(hintText: 'Inserisci nuovo todo'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          if (_newTodoController.text.isNotEmpty) {
            notifier.addTodo(_newTodoController.text);
            _newTodoController.clear();
          }
        },
      ),
    );
  }
}
