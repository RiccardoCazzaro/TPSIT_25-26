import 'package:flutter/material.dart';
import 'notifier.dart';
import 'widgets.dart';
import 'model.dart';

void main() => runApp(const MaterialApp(home: HomePage()));

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final n = WarehouseNotifier();

  @override
  void initState() {
    super.initState();
    n.carica();
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Warehouse')),
      body: ChangeNotifierProvider(
        create: (_) => n,
        child: const ProductList(),
      ),
    );
  }
}


