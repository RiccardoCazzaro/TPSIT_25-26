# Chatroom

Riccardo Cazzaro 5IE
<br>
<br>

È una chatroom in cui più utenti possono connettersi a un server TCP e scambiarsi messaggi in tempo reale.<br>

## L'interfaccia utente

**CONNESSIONE AL SERVER**

● Campo IP Server: inserimento dell’indirizzo IP del server

● Campo Porta: inserimento della porta TCP

● Pulsante Invia IP / Connetti:
  - Avvia la connessione TCP al server
  - Se IP o Porta non sono validi, viene mostrato un messaggio di errore

Dopo la connessione: <BR>
- I campi IP e Porta vengono disabilitati <BR>
- La chat viene inizializzata
<br><br>
    
**NOME UTENTE**  
● Campo Nome Utente:
 - Attivo solo quando si è connessi
 - Disabilitato dopo l’invio del nome

● Pulsante "Invia Nome”:
 - Attivo solo se l’utente è connesso e non ha ancora inviato un nome
 - Il nome non può essere vuoto o composto solo da spazi

Se il nome non è valido:
 - Viene mostrato un messaggio di avviso
 - L’utente non puo ancora scrivere
<br>
    
**AREA CHAT**  
● Visualizza tutti i messaggi ricevuti e inviati in ordine cronologico  
● La cronologia:
 - Viene cancellata alla disconnessione
 - Se ti disconetti non puoi vederla
<br> 

**Invio Messaggi**  
● Campo Messaggio:  
 - Abilitato solo se l’utente è connesso e ha inserito un nome valido  
  
● Pulsante Invia / Tasto Invio:  
 - Invia il messaggio al server  
