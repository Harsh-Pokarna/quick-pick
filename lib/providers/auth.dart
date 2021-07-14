import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quick_pick/models/http_exception.dart';
import 'package:quick_pick/providers/products_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  bool get isAuth {
    return token != null;
  }

  Future<void> setAuthToken(String _authToken) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    prefs.setString('authToken', _authToken);
    notifyListeners();
  }

  Future<String> get token async {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    String url = '';
    (urlSegment == 'signupNewUser')
        ? url =
            'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDqBbz23MgZ8nZMY3vpCiySGNbHVYNzJXY'
        : url =
            'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDqBbz23MgZ8nZMY3vpCiySGNbHVYNzJXY';
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      setAuthToken(_token);
      _userId = responseData['localId'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> signUp(String email, String password) {
    return _authenticate(email, password, 'signupNewUser');
  }

  Future<void> login(String email, String password) {
    return _authenticate(email, password, 'verifyPassword');
  }
}
