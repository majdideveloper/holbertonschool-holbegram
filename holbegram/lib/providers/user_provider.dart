import 'package:flutter/foundation.dart';
import 'package:holbegram/methods/auth_methods.dart';
import 'package:holbegram/models/users.dart';

class UserProvider with ChangeNotifier {
  Users? _user;
  final AuthMethods _authMethode = AuthMethods();

  Users? get user => _user;

  Future<void> refreshUser() async {
    final user = await _authMethode.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
