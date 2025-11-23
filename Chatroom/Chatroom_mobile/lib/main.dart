import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ChatPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  Socket? socket;
  List<String> messaggi = [];
  TextEditingController nomeController = TextEditingController();
  TextEditingController messaggioController = TextEditingController();

  bool connesso = false;
  bool nomeInviato = false;

  String host = "192.168.178.59";
  int port = 3000;

  void connettiODisconnetti() {
    if (connesso) {
      socket?.destroy();
      socket = null;
      setState(() {
        connesso = false;
        nomeInviato = false;
        messaggi.clear();
      });
      aggiungi("Disconnesso dal server");
      return;
    }

    Socket.connect(host, port).then((s) {
      socket = s;
      setState(() => connesso = true);
      aggiungi("✔ Connesso al server ${s.remoteAddress.address}:${s.remotePort}");

      socket!.listen((data) {
        String text = utf8.decode(data);
        for (var riga in text.split("\n")) {
          riga = riga.trim();
          if (riga.isEmpty) continue;
          aggiungi(riga);
        }
      }, onError: (e) {
        aggiungi("Errore socket: $e");
        socket?.destroy();
        setState(() {
          connesso = false;
          nomeInviato = false;
        });
      }, onDone: () {
        aggiungi("Connessione chiusa dal server");
        socket?.destroy();
        setState(() {
          connesso = false;
          nomeInviato = false;
        });
      });
    }).catchError((e) {
      aggiungi(" Impossibile connettersi: $e");
      setState(() {
        connesso = false;
        nomeInviato = false;
      });
    });
  }

  void invia(String testo) {
    if (connesso && testo.trim().isNotEmpty) socket?.write("$testo\n");
  }

  void aggiungi(String msg) {
    setState(() => messaggi.add(msg));
  }

  @override
  void dispose() {
    nomeController.dispose();
    messaggioController.dispose();
    socket?.destroy();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chat TCP Mobile")),
      body: Column(
        children: [
          // Campo Nome + Pulsanti
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: nomeController,
                  decoration: const InputDecoration(hintText: "Nome"),
                  enabled: connesso && !nomeInviato,
                ),
              ),
              if (connesso && !nomeInviato)
                ElevatedButton(
                  onPressed: () {
                    String t = nomeController.text.trim();
                    if (t.isNotEmpty) {
                      invia(t);
                      nomeController.clear();
                      setState(() => nomeInviato = true);
                    } else {
                      aggiungi("⚠️ Nome non valido");
                    }
                  },
                  child: const Text("Invia nome"),
                ),
              ElevatedButton(
                onPressed: connettiODisconnetti,
                child: Text(connesso ? "Disconnetti" : "Connetti"),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Messaggi
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var m in messaggi) Text(m),
                ],
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Campo Messaggio
          if (connesso && nomeInviato)
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messaggioController,
                    decoration: const InputDecoration(hintText: "Scrivi..."),
                    onSubmitted: (t) {
                      invia(t);
                      messaggioController.clear();
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    invia(messaggioController.text);
                    messaggioController.clear();
                  },
                ),
              ],
            ),
        ],
      ),
    );
  }
}
