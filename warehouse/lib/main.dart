import 'package:flutter/material.dart';
import 'notifier.dart';
import 'widgets.dart';
import 'model.dart';

void main() {
  runApp(const MaterialApp(home: PaginaPrincipale()));
}

class PaginaPrincipale extends StatefulWidget {
  const PaginaPrincipale({super.key});

  @override
  State<PaginaPrincipale> createState() => _PaginaPrincipaleState();
}

class _PaginaPrincipaleState extends State<PaginaPrincipale> {
  final magazzino = MagazzinoNotifier();

  @override
  void initState() {
    super.initState();
    magazzino.carica();
  }

  void _mostraDialogo(Product prodotto, bool isAcquisto) {
    final controller = TextEditingController(text: '1');

    String titolo;
    if (isAcquisto) {
      titolo = 'Acquista unità';
    } else {
      titolo = 'Vendi unità';
    }

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(titolo),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Annulla'),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.pop(ctx);

              int q = int.tryParse(controller.text) ?? 0;
              if (q <= 0) return;

              int variazione;
              if (isAcquisto) {
                variazione = q;
              } else {
                variazione = -q;
              }

              final msg = await magazzino.aggiornaQuantita(
                prodotto,
                variazione,
              );

              if (mounted) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(msg)));
              }
            },
            child: const Text('Conferma'),
          ),
        ],
      ),
    );
  }

  IconData _iconaConnessione() {
    if (magazzino.online) {
      return Icons.cloud_done;
    }
    return Icons.cloud_off;
  }

  Color _coloreConnessione() {
    if (magazzino.online) {
      return Colors.green;
    }
    return Colors.red;
  }

  Widget _corpoLista() {
    if (magazzino.caricamento) {
      return const Center(child: CircularProgressIndicator());
    }

    final cards = magazzino.prodotti.map((p) {
      return CartaProdotto(
        prodotto: p,
        online: magazzino.online,
        occupato: magazzino.occupato,
        alClickAcquista: () => _mostraDialogo(p, true),
        alClickVendi: () => _mostraDialogo(p, false),
      );
    }).toList();

    return SingleChildScrollView(child: Column(children: cards));
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: magazzino,
      builder: (context, _) => Scaffold(
        appBar: AppBar(
          title: const Text('Magazzino'),
          actions: [
            Icon(_iconaConnessione(), color: _coloreConnessione()),
            const SizedBox(width: 15),
          ],
        ),
        body: Column(
          children: [
            if (magazzino.occupato) const LinearProgressIndicator(),
            Expanded(child: _corpoLista()),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: magazzino.carica,
          child: const Icon(Icons.refresh),
        ),
      ),
    );
  }
}
