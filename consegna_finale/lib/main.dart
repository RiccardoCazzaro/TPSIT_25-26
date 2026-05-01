import 'package:flutter/material.dart';

void main() {
  runApp(const FutsalApp());
}

class FutsalApp extends StatelessWidget {
  const FutsalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Futsal Manager",
      theme: ThemeData(
        useMaterial3: true,
      ),
home: //da creare
    );
  }
}
