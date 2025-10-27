import 'package:flutter/material.dart';

void main() {
  runApp(const ChronoApp());
}

class ChronoApp extends StatelessWidget {
  const ChronoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cronometro Interfaccia',
      home: ChronoScreen(),
    );
  }
}

class ChronoScreen extends StatefulWidget {
  const ChronoScreen({super.key});

  @override
  State<ChronoScreen> createState() {
    return _ChronoScreenState();
  }
}

class _ChronoScreenState extends State<ChronoScreen> {
  String _displayTime = '00:00.00';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cronometro Interfaccia'),
        backgroundColor: Colors.red, 
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          _displayTime,
          style: const TextStyle(
            fontSize: 80,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'pause_resume',
            backgroundColor: Colors.red,
            onPressed: () {},
            tooltip: 'PAUSE / RESUME',
            child: const Icon(Icons.pause),
          ),
          const SizedBox(width: 29),
          FloatingActionButton(
            heroTag: 'control',
            backgroundColor: Colors.red,
            onPressed: () {},
            tooltip: 'START / STOP / RESET',
            child: const Icon(Icons.play_arrow),
          ),
        ],
      ),
    );
  }
}
