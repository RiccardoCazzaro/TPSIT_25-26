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
  print("Connessione da ${client.remoteAddress.address}:${client.remotePort}");
  client.write("Inserisci il tuo nome utente:\n");
  ChatClient chatClient = ChatClient(client);
  clients.add(chatClient);
}

void removeClient(ChatClient c) {
  if (c.nomeUtente != "Anonimo") {
    distributeMessage(c, "${c.nomeUtente} ha lasciato la chat");
  }
  print("Client disconnesso: ${c._address}:${c._port}");
  clients.remove(c);
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
      if (msg.isEmpty) {
        _socket.write("Il nome utente non è valido. Riprova:\n");
        return;
      }

      nomeUtente = msg;
      _nomeInserito = true;

      _socket.write("Benvenuto $nomeUtente!\n");
      distributeMessage(this, "$nomeUtente è entrato nella chat");
      return;
    }

    distributeMessage(this, "$nomeUtente: $msg");
  }

  void errorHandler(error) {
    print("$_address:$_port Error: $error");
    removeClient(this);
    _socket.close();
  }

  void finishedHandler() {
    print("$_address:$_port Disconnesso");
    removeClient(this);
    _socket.close();
  }

  void write(String message) {
    _socket.write(message);
  }
}
