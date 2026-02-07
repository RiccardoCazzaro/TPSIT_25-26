# Todo List - Stile Google Keep - db

Cazzaro Riccardo 5IE

## Descrizione
L'applicazione è una versione avanzata e persistente di Google Keep. Permette all'utente di organizzare i propri impegni attraverso "Note" (Card) che contengono al loro interno liste di sotto-attività (Todo), garantendo il salvataggio dei dati anche dopo la chiusura dell'app.

- creazione, modifica ed eliminazione di Note e relativi Todo
- ogni nota permette di aggiungere infiniti Todo tramite il pulsante (+) interno alla card si puossono creare più note con all'interno più todo
- tap sul testo per modificare direttamente il titolo delle note (in grassetto) o il testo del todo 
- checkbox per il completamento delle attività con feedback (testo sbarrato)
- dentro le card pulsante (+) con cui puoi aggiungere todo e icona (cestino) per eliminare la nota
- in basso a destra pulsante (+) per aggiungere una nota
- salvataggio di note anche senza titolo o senza Todo e con modifiche
- all'eliminare della nota si eliminano anche i todo interni a essa
- aggiungimento delle note in maniera ordinata (all'inizio in centro e all'aumentare si spostano verso destra creando una riga)
- titolo iniziale todo e note ""
- uso di ListTile per la parte superiore della nota (titolo-intestazione)
- utilizzo di wrap con spacing e runSpacing(spazio orizzontale e verticale) per la disposizione delle note



## Scelte tecniche 
- StatefulWidget (MyHomePage): utilizzato per la schermata principale per gestire la vita dell'app
- StatelessWidget (NoteCard e TodoItem): utilizzati per i componenti delle note e dei singoli compiti
- operazioni database asincrone per evitare ilm blocco della UI
- nelle tabelle del database:
    1. id AUTOINCREMENT per le note e i todo
    2. ON DELETE CASCADE in modo che nel caso si cancellasse 'id_nota' si cancellino anche i todo aventi quella FK
    3. titolo NOT NULL per le note e i todo 
- context.read<TodoListNotifier>(): utilizzato all'interno dei gestori di eventi, come il onPressed dei pulsanti (+) o del cestino per richiamare le funzioni
- context.watch<TodoListNotifier>(): utilizzato all'interno del metodo build della home per reagire immediatamente quando viene chiamato il notifyListeners() ridisegnando la UI
- metodi toMap()(da Dart a SQLite) e fromMap()(dal database a Dart) per caricare e scaricare dati dal SQLite che trasformano i dati in modo compatibile
