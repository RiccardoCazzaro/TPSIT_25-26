# Inferior Mind

Cazzaro Riccardo 
5IE

Inferior Mind è un gioco interattivo in Flutter in cui l’utente deve indovinare una combinazione segreta di 4 colori.  
L’interfaccia ha quattro bottoni circolari, inizialmente grigi, che cambiano colore quando vengono premuti
e un bottone sottostante con cui il giocatore può verificare se la combinazione scelta è corretta,
mentre la combinazione da indovinare rimane sempre nascosta.  
Ogni volte che si preme il bottone di verifica i colori dei 4 pulsanti ritorneranno grigi (colore iniziale).

<br> <br>

## Scelte di sviluppo

**ElevatedButton**: con CircleBorder: cosi da creare bottoni circolari facilmente riconoscibili e interattivi

**Lista di colori**: permette di cambiare i colori in modo semplice senza utilizzare tanti if

**ShowDialog**: per mostrare subito l’esito del tentativo (giusto o sbagliato)

**Alertdialog**: semplice, richiede poco codice e funzioni già pronte per quello che ci serve

**ElevatedButton**: sono facilmente visibili grazie all’ombra che fa capire all’utente che possono essere cliccati

**Setstate()**: per aggiornare ogni volta la schermata al cambio dei dati
