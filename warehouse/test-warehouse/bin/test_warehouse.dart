import 'package:http/http.dart' as http;
import 'dart:convert';


//verificare funzionamento nn so se va boh
void main() async {
  final url = Uri.parse('http://localhost:3000/products');

  print('--- TEST STEP 1: WAREHOUSE REST ---');

  try {
    print('\n1. Lettura prodotti...');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List prodotti = jsonDecode(response.body);
      print('Successo! Trovati ${prodotti.length} prodotti.');
      print('Esempio primo prodotto: ${prodotti.first['name']}');
    }

    print('\n2. Test modifica (aggiornamento quantità prodotto ID 1)...');
    final resPut = await http.put(
      Uri.parse('http://localhost:3000/products/1'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "id": "1",
        "name": "Martello",
        "description": "Martello da carpentiere 500g",
        "category": "Utensileria",
        "price": 12.99,
        "n": 60, 
      }),
    );

    if (resPut.statusCode == 200) {
      print('Aggiornamento riuscito sul server!');
    } else {
      print('Errore durante la modifica: ${resPut.statusCode}');
    }
  } catch (e) {
    print('ERRORE: Il server è acceso? Lancialo con:');
    print('json-server --watch warehouse.json --port 3000');
  }
}
