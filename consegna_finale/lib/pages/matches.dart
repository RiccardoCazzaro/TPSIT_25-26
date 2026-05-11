class MatchModel {
  final int? id;
  final String opponent;
  final String date;
  final int goalsFor;
  final int goalsAgainst;
  final int is_syncronized;

  MatchModel({
    this.id,
    required this.opponent,
    required this.date,
    required this.goalsFor,
    required this.goalsAgainst,
    required this.is_syncronized,
  });

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    return MatchModel(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()),
      opponent: json['opponent'],
      date: json['date'],
      goalsFor: int.parse(json['goals_for'].toString()),
      goalsAgainst: int.parse(json['goals_against'].toString()),
      is_syncronized: json['is_syncronized'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "opponent": opponent,
      "date": date,
      "goals_for": goalsFor,
      "goals_against": goalsAgainst,
    };
  }
}
