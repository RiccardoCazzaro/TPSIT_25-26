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

  TextEditingController ipController = TextEditingController();
  TextEditingController portController = TextEditingController();
  bool ipInserito = false;

  bool connesso = false;
  bool nomeInviato = false;
  String nomeUtente = "";

  String host = "";
  int port = 0;

  void connettiODisconnetti() {
    if (connesso) {
      socket?.destroy();
      socket = null;
      setState(() {
        connesso = false;
        nomeInviato = false;
        nomeUtente = "";
        messaggi.clear();
        ipInserito = false; 
      });
      aggiungi("Disconnesso dal server");
      return;
    }

    Socket.connect(host, port).then((s) {
      socket = s;
      setState(() {
        connesso = true;
        ipInserito = true; 
      });
      aggiungi("Connesso al server ${s.remoteAddress.address}:${s.remotePort}");

      socket!.listen((data) {
        String text = utf8.decode(data);
        for (var riga in text.split("\n")) {
          riga = riga.trim();
          if (riga.isNotEmpty) 
          aggiungi(riga);
        }
      }, onError: (e) {
        aggiungi("Errore socket: $e");
        socket?.destroy();
        setState(() {
          connesso = false;
          nomeInviato = false;
          nomeUtente = "";
          ipInserito = false; 
        });
      }, onDone: () {
        aggiungi("Connessione chiusa dal server");
        socket?.destroy();
        setState(() {
          connesso = false;
          nomeInviato = false;
          nomeUtente = "";
          ipInserito = false; 
        });
      });
    }).catchError((e) {
      aggiungi("Impossibile connettersi");
      setState(() => ipInserito = false); 
    });
  }

  void invia(String testo) {
    String t = testo.trim();
    if (!connesso || t.isEmpty) return;
    if (nomeInviato) {
      aggiungi(t);
      socket?.write("$t\n");
    } else {
      nomeUtente = t;
      nomeInviato = true;
      socket?.write("$t\n");
    }
  }

  void aggiungi(String msg) {
    setState(() => messaggi.add(msg));
  }

  @override
  void dispose() {
    nomeController.dispose();
    messaggioController.dispose();
    ipController.dispose();     
    portController.dispose();  
    socket?.destroy();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chat TCP Mobile")),
      body: Column(
        children: [
          if (!ipInserito)
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: ipController,
                    decoration: const InputDecoration(hintText: "IP"),
                  ),
                ),
                SizedBox(
                  width: 80,
                  child: TextField(
                    controller: portController,
                    decoration: const InputDecoration(hintText: "Porta"),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    host = ipController.text.trim();
                    port = int.tryParse(portController.text.trim()) ?? 0;
                    if (host.isEmpty || port <= 0) {
                      aggiungi("IP o porta non validi");
                      return;
                    }
              setState(() {
                      messaggi.clear(); 
            });
                    connettiODisconnetti(); 
                  },
                  child: const Text("Invia IP"),
                ),
              ],
            ),
          if (ipInserito)
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
                      } else {
                        aggiungi("Nome non valido");
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

         Expanded(
            child: ListView(
            children: [
            for (var m in messaggi)
                Text(m),
               ],
             ),
          ),

          const SizedBox(height: 8),

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