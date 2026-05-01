
# Futsal Manager
### Cazzaro Riccardo — Progetto Finale

App Flutter per gestire giocatori e partite di una squadra di calcio a 5, con sincronizzazione tra database locale (SQLite) e server REST (json-server).

---

## Funzionalità

| Area     | Operazioni |
|---       |---         |
| Giocatori| Lista, aggiungi, modifica, elimina (nome + numero maglia)          |
| Partite | Lista, aggiungi, modifica, elimina (avversario, data, gol fatti/subiti) |

---

## Descrizione dei file

**`db.json`**
Database usato da json-server. Viene aggiornato automaticamente ad ogni operazione CRUD

**`api.dart`**
Servizio HTTP che modifica il json-server

**`db_service.dart`**
Gestisce il database SQLite locale tramite `sqflite`. Usato per la funzione offline e per tracciare gli elementi non ancora sincronizzati (`is_synchronized`)

**`player.dart` / `match.dart`**
Modelli dati

**`players.dart` / `matches.dart`**
Schermate con la lista degli elementi. Ogni voce ha il pulsante di modifica e quello di eliminazione (con dialogo di conferma)

**`add_player.dart` / `add_match.dart`**
Pagina unica per aggiungere e modificare. Se si sta modificando un elemento esistente

