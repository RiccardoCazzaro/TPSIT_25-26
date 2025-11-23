import 'dart:io';


late ServerSocket server;
List<ChatClient> clients = [];


void main() {
  ServerSocket.bind(InternetAddress.anyIPv4, 3000).then((ServerSocket socket) {
    server = socket;
    print("SERVER CONNESSO su ${server.address.address}:${server.port}");


    server.listen((client) {
      handleConnection(client);
    });
  });
}


void handleConnection(Socket client) {
  print('Connessione da ${client.remoteAddress.address}:${client.remotePort}');
  ChatClient chatClient = ChatClient(client);
  clients.add(chatClient);


  client.write("Sei connesso al server!\n");
  client.write("Inserisci il tuo nome utente:\n");
}


void removeClient(ChatClient client) {
  clients.remove(client);
  if (client.nomeUtente != "Anonimo") {
    distributeMessage(client, "Cliente ${client.nomeUtente} si è disconnesso.");
  }
  client.write("Sei disconnesso.\n");
}


void distributeMessage(ChatClient mittente, String message) {
  for (ChatClient c in clients) {
    if (c != mittente) {
      c.write("$message\n");
    }
  }
}


class ChatClient {
  late Socket _socket;
  String nomeUtente = "Anonimo";
  bool _nomeInserito = false;


  String get _address => _socket.remoteAddress.address;
  int get _port => _socket.remotePort;


  ChatClient(Socket s) {
    _socket = s;
    _socket.listen(
      messageHandler,
      onError: errorHandler,
      onDone: finishedHandler,
    );
  }


  void messageHandler(List<int> data) {
    String msg = String.fromCharCodes(data).trim();


    if (!_nomeInserito) {
      if (msg.trim().isEmpty) {
        _socket.write("Nome non valido. Riprova:\n");
        return;
      }
      nomeUtente = msg;
      _nomeInserito = true;
      _socket.write("Benvenuto $nomeUtente!\n");
      _socket.write("Ci sono ${clients.length - 1} altri client connessi\n");
      return;
    }



    if (msg.isEmpty) return;


    distributeMessage(this, "$nomeUtente: $msg"); 
    _socket.write("$msg\n"); 
  }


  void errorHandler(error) {
    print('Errore da $_address:$_port -> $error');
    removeClient(this);
    _socket.close();
  }


  void finishedHandler() {
    print('$_address:$_port Disconnesso');
    removeClient(this);
    _socket.close();
  }


  void write(String message) {
    _socket.write(message);
  }
}





