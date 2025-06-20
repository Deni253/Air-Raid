class UserModel {
  final String name;
  final int score;

  UserModel({required this.name, this.score = 0});

  factory UserModel.fromMap(Map<dynamic, dynamic> map) {
    return UserModel(name: map['name'], score: map['score'] ?? 0);
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'score': score};
  }
}
