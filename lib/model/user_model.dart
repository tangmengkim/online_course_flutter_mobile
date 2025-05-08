import 'dart:convert';

class User {
  final int id;
  final String name;
  final String email;
  final String? avatar;
  final String? role;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
    this.role,
  });

  /// Convert JSON to User object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      avatar: json['avatar'],
      role: json['role'],
    );
  }

  /// Convert User object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatar': avatar,
      'role': role,
    };
  }

  /// Convert a JSON string to a User object
  static User fromJsonString(String jsonString) {
    return User.fromJson(jsonDecode(jsonString));
  }

  /// Convert User object to a JSON string
  String toJsonString() {
    return jsonEncode(toJson());
  }
}
