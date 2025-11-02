# CHRONO
Cazzaro Riccardo  
5IE




## Descrizione
Il **Cronometro** è un’applicazione interattiva realizzata in Flutter che misura
il tempo trascorso mostrando minuti e secondi in un display centrale (es. 00:00).  
Alla base del suo funzionamento ci sono due *Stream* collegati tra loro:
il primo, chiamato **ticker** genera, a intervalli regolari, degli eventi detti *tick*,
mentre il secondo *Stream* elabora questi eventi e li trasforma in secondi.  


L'interfaccia, oltre ad essere composta dal display, ha due pulsanti:
 - lI pulsante principale gestisce gli stati **START**, **STOP** e **RESET**
   
 - Il secondo pulsante permette di mettere in **PAUSA** o **RIPRENDERE (RESUME)**
   il conteggio dal punto in cui si era interrotto


<br>



## Stato
Il cronometro si attiva quando l'utente preme il pulsante Avvio:  


**AVVIO**  
   - chiama funzione di avvio, la variabile avvio diventa true e pausa diventa false
   - Questa modifica viene comunicata e tramite setState() l'icona del pulsante si trasforma immediatamente da Play a Stop 
<br>


**STREAM**  
   - ***Creazione dello stream:*** viene aperto un canale di       comunicazione (StreamController(_controllerTicker))
    <br>
   -  ***Avvio:*** viene attivato un timer periodico che scatta ogni 100 millisecondi (0.1 secondi)  
   - ***Lancio dei Segnali (Tick):*** ad ogni scatto del Timer, un contatore (_tick) aumenta e il suo valore viene inviato nel canale
   - ***Connessione tramite canale (pipe):*** viene creato il convertitore del tempo (secondiStream()) che riceve tutti i tick.
    Un Ascoltatore (StreamSubscription(_secondiTot)) viene subito collegato all'uscita del canale    

  <br>
   
**ESECUZIONE PIPE** (il convertitore riceve i tick e li conta) <br> 
- ***Trasformazione:*** La funzione arrivata a 10 tick (10 * 100ms) li converte in un secondo
 e di conseguenza arrivati a 60 tick li convertirà in un minuto e zero secondi(01:00)  
- ***Aggiornamento dello Schermo:*** l'Ascoltatore una volta ricevuto il secondo (10 tick) calcola quanti minuti e secondi sono passati
 e chiama setState() per aggiornare il display visualizzato

<br> 

## Scelte di sviluppo
- **FloatingActionButton:** utilizza un Widget Row all'interno del floatingActionButton dello Scaffold per posizionare i due pulsanti affiancati in basso a destra
- **Gestione dello stato con booleani:** variabili avvio e pausa per definire il funzionamento e le icone dei pulsanti
- **Ascolto tramite .listen():** per rendere esecuzione asincrona senza bloccare l'applicazione
- **Timer:** per generare il segnale di tempo (tick) ricorrente ogni 100ms che alimenta lo Stream
- **StreamSubscription:** l'ascoltatore (secondiTot) permette di fermare l'ascolto (.cancel())
- **StreamController?.close():** per chiudere il canale di input dello Stream (_controllerTicker?.close())








