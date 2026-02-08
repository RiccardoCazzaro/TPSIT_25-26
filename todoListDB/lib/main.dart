import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart'; 
import 'notifier.dart';
import 'widgets.dart';

void main() {
  databaseFactory = databaseFactoryFfi;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'todo list',
      theme:
          ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.red)),
      home: ChangeNotifierProvider(
        create: (context) => TodoListNotifier(),
        child: const MyHomePage(),
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
  void initState() {
    final notifier = context.read<TodoListNotifier>();
    notifier.loadFromDb();
    }
  
  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<TodoListNotifier>();
    return Scaffold(
      appBar: AppBar(
          title: const Text("Todo List Application"),
          centerTitle: true,
          backgroundColor: Colors.red[100]),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 16.0,
            runSpacing: 16.0,
          children: [
            for (int i = 0; i < notifier.length; i++)
            SizedBox(
              width: 400,
              child: NoteCard(note: notifier.getNote(i), noteIndex: i),
              ),
            if (notifier.length == 0)
              const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text("Aggiungi una nuova nota (schiaccia +)")),
          ],
        ),
      ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => notifier.addNote(""),
      ),
    );
  }
}
