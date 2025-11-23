# Chatroom

Riccardo Cazzaro 5IE
<br>
<br>

È una chatroom in cui più utenti possono connettersi a un server TCP e scambiarsi messaggi in tempo reale.<br>
L'interfaccia utente:


● **Campo Nome + Pulsanti Connessione**

- Un campo di testo per inserire il Nome Utente

- Pulsante Invia Nome attivo solo se sei connesso e non hai ancora inserito un nome valido

- Pulsante Connetti / Disconnetti per aprire o chiudere la connessione TCP

- Il campo Nome si abilita solo quando sei connesso e non hai ancora inviato il nome

● **Area Chat / Messaggi**

- Mostra tutti i messaggi ricevuti dalla chat in ordine cronologico

- La chat si aggiorna automaticamente quando arrivano nuovi messaggi

- La cronologia viene cancellata quando ci si disconnette

● **Campo Messaggio + Pulsante Invia**

- Un campo di testo per scrivere messaggi

- Pulsante Invia o tasto invio per inviare il messaggio

- Il campo e il pulsante sono attivi solo se hai già inserito un nome valido

- Non è possibile inviare messaggi vuoti o composti solo da spazi

- Stati principali della UI:

- Disconnesso: solo campo nome e pulsante Connetti attivi, area chat vuota

- Connesso senza nome: campo Nome attivo, campo Messaggio disabilitato, pulsante Disconnetti attivo

- Connesso con nome: campo Messaggio e pulsante Invia attivi, campo Nome disabilitato, pulsante Disconnetti attivo


### Protocollo

**Connessione**: La connessione al server TCP è possibile senza aver inserito il nome utente

**Nome Utente Obbligatorio**: È necessario un Nome Utente valido (non vuoto o solo spazi) per poter inviare messaggi

**Messaggio**: I messaggi inviati non possono essere vuoti o contenere solo spazi

**Disconnessione**: La chiusura della connessione comporta la cancellazionedella chat e il ripristino dello stato iniziale della UI

**Aggiornamento UI**: L'interfaccia si aggiorna automaticamente in base allo stato di connessione e autenticazione

### Interfaccia Utente (UI) e Stati  
La UI ha tre stati principali che determinano l'accessibilità dei campi e dei pulsanti  


● **Stato Iniziale (Disconnesso)** 
- Campi Abilitati: IP Server e Porta, Nome Utente  

- Pulsante Attivo: Connetti  

- Stato Chat: messaggi nn scritti



● **Stato Connesso (Nome non impostato)**  
 
  - Stato TCP: Connessione al server stabilita  

  - Campi Disabilitati: IP Server e Porta  

  - Campi Abilitati: Nome Utente  

  - Campo Messaggio: Disabilitato  

  - Pulsante Attivo: Disconnetti
  

● **Stato Attivo (Connesso e Nome impostato)**

  - Stato Autenticazione: Nome Utente valido associato al socket

  - Campi Disabilitati: Nome Utente

  - Campi Abilitati: Campo Messaggio

  - Pulsanti Attivi: Disconnetti e Invia Messaggio

  - Funzionalità: L'utente può chattare
  
### Gestione Errori (Client)

  ● **Errore di Connessione**  
     - Mostrare un avviso   

  ● **Stato UI**:  La UI deve rimanere nello Stato Iniziale (Disconnesso)  


  ●  **Errore disconnessione forzata**  
     - Mostrare notifica (es. "Connessione persa.")  
     - cancella chat, disabilita alcuni campi, torna allo Stato Iniziale  


  ● **Nome Utente non Valido o Già in Uso**
    - Azione: Mostrare un avviso all'utente (es. "Nome non valido o già in uso.")  

  ● **Messaggio Vuoto**  
     - Bloccare l'invio se il campo messaggio è vuoto o contiene solo spazi, manda avviso  