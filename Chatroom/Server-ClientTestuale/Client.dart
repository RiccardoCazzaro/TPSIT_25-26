import 'dart:io';

late Socket socket;
String? username;

void main() {
  bool richiediInput = true;
  while (richiediInput) {
    stdout.write("Inserisci il tuo nome utente: ");
    String? input = stdin.readLineSync()?.trim();
    if (input != null && input.isNotEmpty) {
      username = input;
      richiediInput = false;
    } else {
      stderr.write("Nome non valido. Riprova.\n");
    }
  }

  Socket.connect("localhost", 3000).then((Socket sock) {
    socket = sock;
    socket.listen(dataHandler,
        onError: errorHandler, onDone: doneHandler, cancelOnError: false);
    socket.write("USERNAME:${username!}\n");
  }, onError: (e) {
    print("Unable to connect: $e");
    exit(1);
  });
  stdin
      .listen((data) => socket.write(String.fromCharCodes(data).trim() + '\n'));
}

void dataHandler(data) {
  print(String.fromCharCodes(data).trim());
}

void errorHandler(error, StackTrace trace) {
  print(error);
}

void doneHandler() {
  socket.destroy();
  exit(0);
}
