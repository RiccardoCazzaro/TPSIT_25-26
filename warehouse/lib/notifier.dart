import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model.dart';


//incompleto nn va

class WarehouseNotifier extends ChangeNotifier {
  List<Product> prodotti = [];
  bool online = false;
  bool caricamento = true;
  bool busy = false;

  static const url = 'http://localhost:3000';

  Future<void> carica() async {
    caricamento = true;
    notifyListeners();
    try {
      final r = await http
          .get(Uri.parse('$url/products'))
          .timeout(const Duration(seconds: 4));
      if (r.statusCode == 200) {
        prodotti = (jsonDecode(r.body) as List)
            .map((j) => Product.fromJson(j))
            .toList();
        online = true;
      }
    } catch (_) {
      online = false;
    }
    caricamento = false;
    notifyListeners();
  }

  Future<String> aggiornaQuantita(Product p, int variazione) async {
    if (!online) return "Impossibile operare offline";
    if (p.n + variazione < 0) return "Quantità insufficiente";

    busy = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 3));

    final nuovo = p.copyWith(n: p.n + variazione);
    final ok = await _put(nuovo);

    if (ok) {
      final i = prodotti.indexWhere((x) => x.id == p.id);
      if (i != -1) prodotti[i] = nuovo;
    }

    busy = false;
    notifyListeners();
    return ok ? 'Operazione completata' : 'Errore server';
  }

  Future<bool> _put(Product p) async {
    try {
      final r = await http.put(
        Uri.parse('$url/products/${p.id}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(p.toJson()),
      );
      return r.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}
