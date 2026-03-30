import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'model.dart';

class MagazzinoNotifier extends ChangeNotifier {
  List<Product> prodotti = [];
  bool online = false;
  bool caricamento = true;
  bool occupato = false;

  static const url = 'http://localhost:3000';

  Future<void> carica() async {
    caricamento = true;
    notifyListeners();

    try {
      final res = await http
          .get(Uri.parse('$url/products'))
          .timeout(const Duration(seconds: 4));

      if (res.statusCode == 200) {
        prodotti = (jsonDecode(res.body) as List)
            .map((j) => Product.fromJson(j))
            .toList();
        online = true;
      } else {
        online = false;
      }
    } catch (e) {
      online = false;
    }

    caricamento = false;
    notifyListeners();
  }

  Future<String> aggiornaQuantita(Product prodotto, int variazione) async {
    if (!online) return 'Impossibile operare offline';

    int nuova = prodotto.quantita + variazione;
    if (nuova < 0) return 'Quantità insufficiente';

    occupato = true;
    notifyListeners();

    int vecchia = prodotto.quantita;
    prodotto.quantita = nuova;

    bool ok = await _salva(prodotto);

    if (ok) {
      occupato = false;
      notifyListeners();
      return 'Operazione completata';
    } else {
      prodotto.quantita = vecchia;
      occupato = false;
      notifyListeners();
      return 'Errore server';
    }
  }

  Future<bool> _salva(Product prodotto) async {
    try {
      final res = await http.put(
        Uri.parse('$url/products/${prodotto.id}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(prodotto.toJson()),
      );
      return res.statusCode == 200 || res.statusCode == 204;
    } catch (e) {
      return false;
    }
  }
}
