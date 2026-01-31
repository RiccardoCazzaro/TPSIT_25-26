import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'notifier.dart';
import 'widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'todo list',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      ),
      home: ChangeNotifierProvider<TodoListNotifier>(
        child: const MyHomePage(),
        create: (context) => TodoListNotifier(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final TodoListNotifier notifier = context.watch<TodoListNotifier>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo List Application"),
        centerTitle: true,
        backgroundColor: Colors.red[100],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            for (int i = 0; i < notifier.length; i++)
              NoteCard(note: notifier.getNote(i), noteIndex: i),
            if (notifier.length == 0)
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text("Aggiungi una nuova nota (schiaccia +)"),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          notifier.addNote("NotaNuova ");
        },
      ),
    );
  }
}
