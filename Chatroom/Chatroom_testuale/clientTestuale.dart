import 'dart:io';

late Socket clientSocket;

void main() {
  Socket.connect("localhost", 3000).then((Socket sock) {
    clientSocket = sock;
    
    clientSocket.listen(
        dataHandler,
        onError: errorHandler, 
        onDone: doneHandler, 
        cancelOnError: false);
    
    stdin.listen(
        (data) => clientSocket.write(String.fromCharCodes(data).trim() + '\n')); 
  }, onError: (e) {
    print("Impossibile connettersi: $e");
    exit(1);
  });
}

void dataHandler(data) {
  stdout.write(String.fromCharCodes(data));
}

void errorHandler(error, StackTrace trace) {
  print("Errore: $error");
}

void doneHandler() {
  print("Connessione chiusa dal server.");
  clientSocket.destroy();
  exit(0);
}