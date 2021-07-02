import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../const/keys.dart';

class Auth with ChangeNotifier {
  DateTime _expiryDate = DateTime.now();

  String _tokenid = "";

  Timer? _timer;

  bool get isAuth {
    return _expiryDate.isAfter(DateTime.now()) && _tokenid.isNotEmpty;
  }

  Future<void> authenticate(
    String email,
    String password,
    bool signUp, [
    String name = "Maichel",
  ]) async {
    try {
      final String process = signUp ? "signUp" : "signInWithPassword";
      final Uri authUrl = Uri.parse(
          "https://identitytoolkit.googleapis.com/v1/accounts:$process?key=${ConstKeys.firebaseApiKey}");
      final Uri firestoreUrl = Uri.parse(
          "https://firestore.googleapis.com/v1/{parent=projects/${ConstKeys.appId}/databases/(default)/collectionGroups/users}/indexes");
      final http.Response firestoreRequest = await http.post(
        firestoreUrl,
        body: json.encode(
          {
            "email": email,
            "name": name,
          },
        ),
      );
      print(
          "AUTH authenticate firestoreRequest body: ${firestoreRequest.body}");
      final request = await http.post(authUrl, body: {
        "email": email,
        "password": password,
        "returnSecureToken": true,
      });
      final extractedRequest = json.decode(request.body);
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.tryParse(extractedRequest["expiresIn"].toString()) ?? 0,
        ),
      );
      _tokenid = extractedRequest["idToken"].toString();
      _saveAuthData(email, password);
      _autoLogout();
    } on Exception catch (error) {
      print("AUTH authenticate error: $error");
      throw error;
    }
  }

  Future<void> _saveAuthData(String email, String password) async {
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      final String data = json.encode({"email": email, "password": password});
      pref.setString(ConstKeys.sharedPreferencesAuthKey, data);
    } on Exception catch (error) {
      print("AUTH _saveAuthData error: $error");
      throw error;
    }
  }

  Future<void> autoLogin() async {
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      if (pref.containsKey(ConstKeys.sharedPreferencesAuthKey)) {
        final Map<String, String> data = json.decode(
          pref.getString(ConstKeys.sharedPreferencesAuthKey).toString(),
        );
        authenticate(
            data["email"].toString(), data["password"].toString(), false);
      }
    } on Exception catch (error) {
      print("AUTH autoLogin error: $error");
      throw error;
    }
  }

  Future<void> logOut() async {
    _tokenid = "";
    _expiryDate = DateTime.now();

    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove(ConstKeys.sharedPreferencesAuthKey);
  }

  void _autoLogout() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
    final int expiresIn = _expiryDate.difference(DateTime.now()).inSeconds;
    _timer = Timer(
      (Duration(seconds: expiresIn)),
      () {
        autoLogin();
      },
    );
  }
}
