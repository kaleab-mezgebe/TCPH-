import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String _role = '';
  String _username = '';

  String get role => _role;
  String get username => _username;

  void setRole(String newRole) {
    _role = newRole;
    notifyListeners(); // Notify listeners about state changes
  }

  void setUsername(String newUsername) {
    _username = newUsername;
    notifyListeners(); // Notify listeners about state changes
  }
}
