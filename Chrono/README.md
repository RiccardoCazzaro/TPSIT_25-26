#CHRONO
Cazzaro Riccardo  
5IE



## Descrizione
Il **Cronometro** è un’applicazione interattiva realizzata in Flutter che misura 
il tempo trascorso mostrando minuti e secondi in modo chiaro e leggibile.
Alla base del suo funzionamento ci sono due *Stream* collegati tra loro: 
il primo, chiamato **ticker**, genera a intervalli regolari degli eventi detti *tuck*,
mentre il secondo *Stream* elabora questi eventi e li trasforma in secondi.  
L’interfaccia mostra il tempo e presenta due pulsanti.
Il primo pulsante consente di passare tra gli stati **START**, **STOP** e **RESET**,
mentre il secondo permette di mettere in **PAUSA** o **RIPRENDERE** (**RESUME**) il cronometro.

