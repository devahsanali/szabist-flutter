import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  String? _token;

  String? get token => _token;
  bool get isLoggedIn => _token != null;

  Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    _token = token;
    await prefs.setString('token', token);
    notifyListeners();
  }

  Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
    notifyListeners();
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    _token = null;
    await prefs.remove('token');
    notifyListeners();
  }
}