import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartnote/utils/service/smartnote_api.dart';

class Auth with ChangeNotifier {
  Auth(this.api);

  final SmartNoteApi api;

  Future<void> login(String username, String password) async {
    username = username.trim();
    password = password.trim();

    final result = await api.authenticate(username, password);
    print(result.body);
    notifyListeners();
  }

  Future signup(
      {required String name,
      required String email,
      required String company,
      required String username,
      required String password}) async {
    APIResult? result;
    result = await api.post("sing api url", body: {
      "name": "$name",
      "email": "$email",
      "companyName": "$company",
      "userName": "$username",
      "password": "$password",
    });

    notifyListeners();

    return result;
  }
}
