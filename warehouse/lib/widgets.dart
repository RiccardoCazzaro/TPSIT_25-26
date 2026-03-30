import 'package:flutter/material.dart';
import 'model.dart';

class CartaProdotto extends StatelessWidget {
  final Product prodotto;
  final bool online;
  final bool occupato;
  final VoidCallback alClickAcquista;
  final VoidCallback alClickVendi;

  const CartaProdotto({
    super.key,
    required this.prodotto,
    required this.online,
    required this.occupato,
    required this.alClickAcquista,
    required this.alClickVendi,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(prodotto.nome),
        subtitle: Text(
          '${prodotto.descrizione} — ${prodotto.quantita} pz — €${prodotto.prezzo.toStringAsFixed(2)}',
        ),
        trailing: online
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.add, color: Colors.green),
                    onPressed: occupato ? null : alClickAcquista,
                  ),
                  IconButton(
                    icon: const Icon(Icons.remove, color: Colors.red),
                    onPressed: occupato ? null : alClickVendi,
                  ),
                ],
              )
            : null,
      ),
    );
  }
}
