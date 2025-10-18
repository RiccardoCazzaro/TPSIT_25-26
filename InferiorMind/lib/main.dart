import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp()); 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(), 
      debugShowCheckedModeBanner: false, 
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Color> colori = [
    Colors.grey,
    Colors.red,
    Colors.green,
    Colors.yellow
  ];

  List<Color> bottoni = List.filled(4, Colors.grey);

  final List<Color> segreto = [
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.red
  ];

  void cambiaColore(int indBottone) {
    setState(() {
      int indColore = colori.indexOf(bottoni[indBottone]); 
      if (indColore == colori.length - 1) indColore = 0;
      else (indColore = indColore + 1);
      bottoni[indBottone] = colori[indColore]; 
    });
  }

  void controlla() {
    bool indovinato = true;
    for (int i = 0; i < 4; i++) {
      if (bottoni[i] != segreto[i]) {
        indovinato = false;
      }
    }

    String titoloMess;
    String messaggio;

    if (indovinato == true) {
      titoloMess = "Hai indovinato!";
      messaggio = "Bravo, hai trovato la combinazione";
    } else {
      titoloMess = "Sbagliato!";
      messaggio = "Ritenta, sarai più fortunato";
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(titoloMess),
          content: Text(messaggio),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.pop(context); 
                setState(() {
                  bottoni = List.filled(4, Colors.grey);
                });              
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text("INDOVINA COLORE"), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Premi i bottoni per cambiare colore"),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 4; i++)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      child: Text("${i + 1}"),
                      onPressed: () => cambiaColore(i),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: bottoni[i],
                        fixedSize: const Size(60, 60),
                        shape: const CircleBorder(), 
                      )
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: controlla,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.check),
      ),
    );
  }
}
