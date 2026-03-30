class Product {
  final String id;
  final String name;
  final String description;
  final String category;
  final double price;
  final int n;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.price,
    required this.n,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json['id'].toString(),
    name: json['name'],
    description: json['description'],
    category: json['category'],
    price: (json['price'] as num).toDouble(),
    n: json['n'] as int,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'category': category,
    'price': price,
    'n': n,
  };

  Product copyWith({int? n}) => Product(
    id: id,
    name: name,
    description: description,
    category: category,
    price: price,
    n: n ?? this.n,
  );
}
