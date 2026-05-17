import "dart:convert";
import "package:http/http.dart" as http;
import "dbHelper.dart";

class ApiService {
  static const base = "http://192.168.178.59:3000";
  static const _t = Duration(seconds: 3);
  static final _h = {"Content-Type": "application/json"};

  static Future<List> getPlayers() async {
    for (var p in (await DBService.getPlayers()).where(
      (p) => p["is_syncronized"] == 0,
    )) {
      try {
        final r = await http
            .post(
              Uri.parse("$base/players"),
              headers: _h,
              body: jsonEncode({
                "name": p["name"],
                "number": p["number"],
                if (p["foot"] != null) "foot": p["foot"],
                if (p["team"] != null) "team": p["team"],
              }),
            )
            .timeout(_t);
        if (r.statusCode == 201) await DBService.deletePlayer(p["id"]);
      } catch (_) {}
    }
    try {
      final r = await http.get(Uri.parse("$base/players")).timeout(_t);
      if (r.statusCode == 200) {
        await DBService.clearPlayers();
        for (var p in jsonDecode(r.body))
          await DBService.insertPlayer({...p, "is_syncronized": 1});
      }
    } catch (_) {}
    return await DBService.getPlayers();
  }

  static Future<void> addPlayer(Map<String, dynamic> d) async {
    try {
      final r = await http
          .post(Uri.parse("$base/players"), headers: _h, body: jsonEncode(d))
          .timeout(_t);
      if (r.statusCode == 201) {
        await DBService.insertPlayer({
          ...jsonDecode(r.body),
          "is_syncronized": 1,
        });
        return;
      }
    } catch (_) {}
    await DBService.insertPlayer({...d, "is_syncronized": 0});
  }

  static Future<void> patchPlayer(int id, Map<String, dynamic> d) async {
    try {
      final r = await http
          .patch(
            Uri.parse("$base/players/$id"),
            headers: _h,
            body: jsonEncode(d),
          )
          .timeout(_t);
      if (r.statusCode == 200 || r.statusCode == 204) {
        await DBService.patchPlayer(id, {...d, "is_syncronized": 1});
        return;
      }
    } catch (_) {}
    await DBService.patchPlayer(id, {...d, "is_syncronized": 0});
  }

  static Future<void> deletePlayer(int id) async {
    try {
      await http.delete(Uri.parse("$base/players/$id")).timeout(_t);
    } catch (_) {}
    await DBService.deletePlayer(id);
  }

  static Future<List> getMatches() async {
    for (var m in (await DBService.getMatches()).where(
      (m) => m["is_syncronized"] == 0,
    )) {
      try {
        final r = await http
            .post(
              Uri.parse("$base/matches"),
              headers: _h,
              body: jsonEncode({
                "opponent": m["opponent"],
                "date": m["date"],
                "goals_for": m["goals_for"],
                "goals_against": m["goals_against"],
                if (m["league_position"] != null)
                  "league_position": m["league_position"],
              }),
            )
            .timeout(_t);
        if (r.statusCode == 201) await DBService.deleteMatch(m["id"]);
      } catch (_) {}
    }
    try {
      final r = await http.get(Uri.parse("$base/matches")).timeout(_t);
      if (r.statusCode == 200) {
        await DBService.clearMatches();
        for (var m in jsonDecode(r.body))
          await DBService.insertMatch({...m, "is_syncronized": 1});
      }
    } catch (_) {}
    return await DBService.getMatches();
  }

  static Future<void> addMatch(Map<String, dynamic> d) async {
    try {
      final r = await http
          .post(Uri.parse("$base/matches"), headers: _h, body: jsonEncode(d))
          .timeout(_t);
      if (r.statusCode == 201) {
        await DBService.insertMatch({
          ...jsonDecode(r.body),
          "is_syncronized": 1,
        });
        return;
      }
    } catch (_) {}
    await DBService.insertMatch({...d, "is_syncronized": 0});
  }

  static Future<void> patchMatch(int id, Map<String, dynamic> d) async {
    try {
      final r = await http
          .patch(
            Uri.parse("$base/matches/$id"),
            headers: _h,
            body: jsonEncode(d),
          )
          .timeout(_t);
      if (r.statusCode == 200 || r.statusCode == 204) {
        await DBService.patchMatch(id, {...d, "is_syncronized": 1});
        return;
      }
    } catch (_) {}
    await DBService.patchMatch(id, {...d, "is_syncronized": 0});
  }

  static Future<void> deleteMatch(int id) async {
    try {
      await http.delete(Uri.parse("$base/matches/$id")).timeout(_t);
    } catch (_) {}
    await DBService.deleteMatch(id);
  }
}
