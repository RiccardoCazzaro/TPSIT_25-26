class Player {
  final int? id;
  final String name;
  final int number;
  final int is_syncronized;

  Player({
    this.id,
    required this.name,
    required this.number,
    required this.is_syncronized,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'],
      name: json['name'],
      number: json['number'],
      is_syncronized: json['is_syncronized'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {"name": name, "number": number};
  }
}
