import 'package:firebase_database/firebase_database.dart';
import '../models/user_model.dart';

class LeaderboardViewModel {
  final DatabaseReference _ref = FirebaseDatabase.instance.ref("Users");

  Future<List<UserModel>> fetchUsers({bool ascending = false}) async {
    final snapshot = await _ref.get();

    if (!snapshot.exists) return [];

    final usersMap = snapshot.value as Map<dynamic, dynamic>;
    final users =
        usersMap.entries.map((entry) {
          final data = entry.value as Map<dynamic, dynamic>;
          return UserModel(
            name: data['username'] ?? 'Unknown',
            score: data['score'] ?? 0,
          );
        }).toList();

    users.sort(
      (a, b) =>
          ascending ? a.score.compareTo(b.score) : b.score.compareTo(a.score),
    );

    return users;
  }
}
