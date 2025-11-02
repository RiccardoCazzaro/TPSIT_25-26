import 'dart:async';
import 'package:flutter/material.dart';


void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Chrono(),
  ));
}


class Chrono extends StatefulWidget {
  const Chrono({super.key});

  @override
  State<Chrono> createState() {
    return _ChronoState();
  }
}

class _ChronoState extends State<Chrono> {
  String displayTempo = "00:00";   
  bool avvio = false;              
  bool pausa = false;              


  StreamController<int>? _controllerTicker;
  StreamSubscription<int>? secondiTot;
  Timer? _timerTicker;
  int _tick = 0;                   

  Stream<int> secondiStream(Stream<int> tickStream) async* {
    await for (final int t in tickStream) {
      if (t % 10 == 0) yield t ~/ 10;
    }
  }


  void avvia() {
    if (avvio) return;


    _controllerTicker = StreamController<int>();
    _tick = 0;
    _controllerTicker!.add(_tick); 


    _timerTicker = Timer.periodic(const Duration(milliseconds: 100), (timer) {
    _tick++;
    _controllerTicker!.add(_tick);
    });


    Stream<int> secondi = secondiStream(_controllerTicker!.stream);


    secondiTot = secondi.listen((int sec) {
      if (!pausa) {
        int min = sec ~/ 60;
        int s = sec % 60;
        setState(() {
        displayTempo =  '${min.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
        });
      }
    });

    setState(() {
      avvio = true;
      pausa = false;
    });
  }

  void reset() {
    _timerTicker?.cancel();
    _controllerTicker?.close();
    secondiTot?.cancel();

    _tick = 0;
    setState(() {
      avvio = false;
      pausa = false;
      displayTempo = "00:00";
    });
  }

  void pausaRiprendi() {
    if (!avvio) return;
  
    if (!pausa) {
      _timerTicker?.cancel();
      setState(() {
        pausa = true; 
     });
    } else {
      _timerTicker = Timer.periodic(const Duration(milliseconds: 100), (timer) {
        _tick++;
        _controllerTicker!.add(_tick);
      });
      setState(() {
        pausa = false;
     });
    }
  }


@override
Widget build(BuildContext context) {
  Icon iconaAvvio;
  if (avvio) {
    iconaAvvio = const Icon(Icons.stop);
  } else {
    iconaAvvio = const Icon(Icons.play_arrow);
  }

  Icon iconaPausa;
  if (pausa) {
    iconaPausa = const Icon(Icons.play_arrow);
  } else {
    iconaPausa = const Icon(Icons.pause);
  }

  return Scaffold(
    appBar: AppBar(
      title: const Text(
        'CRONOMETRO',  
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      backgroundColor: Colors.grey,
      centerTitle: true,
    ),
    
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            displayTempo,
            style: const TextStyle(fontSize: 90, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),

  floatingActionButton: Row(
    mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
           backgroundColor: Colors.grey,
           tooltip: "PAUSA / RIPRESA",
           child: iconaPausa,
           onPressed: () {
             if (avvio) {
               pausaRiprendi();
             }
           },
         ), 

    const SizedBox(width: 20),

        FloatingActionButton(
           backgroundColor: Colors.grey,
           tooltip: "AVVIO / STOP / RESET",
           child: iconaAvvio,
           onPressed: () {
            if (avvio) {
               reset();
             } else {
               avvia();
             }
           },
          ),
       ],
      ),
    );
  }
}