class Product {
  String id;
  String nome;
  String descrizione;
  String categoria;
  double prezzo;
  int quantita;

  Product({
    required this.id,
    required this.nome,
    required this.descrizione,
    required this.categoria,
    required this.prezzo,
    required this.quantita,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'].toString(),
      nome: json['name'],
      descrizione: json['description'],
      categoria: json['category'],
      prezzo: (json['price'] as num).toDouble(),
      quantita: json['n'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': nome,
      'description': descrizione,
      'category': categoria,
      'price': prezzo,
      'n': quantita,
    };
  }
}
