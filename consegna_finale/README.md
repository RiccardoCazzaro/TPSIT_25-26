# Futsal Manager
### Cazzaro Riccardo — Progetto Finale

App Flutter per gestire giocatori e partite di una squadra di calcio a 5, con sincronizzazione tra database locale (SQLite) e json-server.

---

## Funzionalità

| Area     | Operazioni |                                                             
|---       |---         |
| Giocatori| Lista, aggiungi, modifica, elimina (nome + numero maglia + squadra(categoria) + piede(dx sx))               |
| Partite  | Lista, aggiungi, modifica, elimina (avversario, data, gol fatti/subiti, posizione in classifica) |

---

## Descrizione dei file

**`db.json`**
- Database usato da json-server. Viene aggiornato automaticamente ad ogni operazione CRUD

**`api.dart`**
- Servizio HTTP che modifica il json-server

**`dbHelper.dart`**
- Gestisce il database SQLite locale tramite `sqflite`. Usato per la funzione offline e per tracciare gli elementi non ancora sincronizzati (`is_syncronized`)

**`player.dart` / `match.dart`**
- Modelli dati per giocatori e squadre

**`players.dart` / `matches.dart`**
- Schermate con la lista degli elementi. Ogni voce ha il pulsante di modifica e quello di eliminazione (con richiesta di conferma)

**`add_player.dart` / `add_match.dart`**
- Pagina unica per aggiungere o modificare. Se si sta modificando un elemento esistente o aggiungendo un elemento nuovo

---

## Interfaccia utente

### Pagina Giocatori / Pagina Partite

Entrambe le pagine hanno la stessa struttura:

- **AppBar** — barra in alto con il titolo della pagina e le icone a destra:
  - 🔄 **Icona sync (freccia)** — ricarica manualmente la lista dal server e sincronizza i dati offline
  - ⚽ **Icona pallone** (solo Giocatori) — naviga alla pagina Partite
- **ListView** — lista scorrevole con una riga (`ListTile`) per ogni elemento
- **FloatingActionButton** — bottone `+` in basso a destra per aggiungere un nuovo elemento

### Ogni riga della lista (`ListTile`)

| Posizione | Widget | Descrizione |
|---|---|---|
| Sinistra | `Icon` (nuvola) | Verde = sincronizzato col server, Arancione = salvato solo in locale |
| Centro | `Text` (titolo) | Nome giocatore / nome avversario |
| Centro | `Text` (sottotitolo) | Dettagli: numero, piede, squadra / data, risultato, posizione |
| Destra | `IconButton` matita  | Apre il form precompilato per modificare |
| Destra | `IconButton` cestino 🗑️ | Elimina l'elemento |

>il cestino è **grigio e disabilitato** se l'elemento è sincronizzato (`is_syncronized = 1`) e il server non è raggiungibile, per evitare di eliminare localmente qualcosa che esiste ancora sul server. È **rosso e attivo** se si è online oppure se l'elemento è solo locale (`is_syncronized = 0`).


### Pagina Aggiungi / Modifica (add_player / add_match)

- **TextField** per ogni campo (nome, numero, squadra, avversario, gol, ecc.)
- **Campo data** —  apre un `DatePicker` al tap (calendario)
- **Bottoni piede** (solo giocatore) — due `OutlinedButton` affiancati, quello selezionato diventa verde
- **ElevatedButton** in fondo — testo "Aggiungi"/"Crea" se nuovo, "Salva" se modifica

---

## Modalità offline

- Ogni elemento ha un campo `is_syncronized` (0 = solo locale, 1 = sincronizzato col server)
- Le icone nuvola mostrano lo stato di ogni singolo elemento (arancione offline, verde online)
- Premendo 🔄 sync si avvia la sincronizzazione: i dati locali vengono mandati al server, poi la lista viene aggiornata da remoto

---

### Online o offline (per il cestino)
 
In `players.dart` e `matches.dart` c'è un `Timer` che gira in background:
 
- Ogni **500 millisecondi** fa un ping al server (`GET` sull'indirizzo base)
- Se il server risponde → `sonoOnline = true`
- Se non risponde (timeout o errore) → `sonoOnline = false`
- In base a `sonoOnline` il cestino diventa **rosso** (può cancellare) o **grigio** (bloccato)
- Quando esci dalla pagina il timer viene fermato (`dispose`) per non sprecare risorse




