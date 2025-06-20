import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class RegisterViewModel extends ChangeNotifier {
  final AuthService _auth = AuthService();

  Future<String?> register(
    String username,
    String email,
    String password,
  ) async {
    final user = await _auth.register(email, password, username);
    if (user != null) {
      return "Registration successful!";
    } else {
      return 'Registration failed!';
    }
  }
}
