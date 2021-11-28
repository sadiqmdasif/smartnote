import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartnote/core/screen/bottom_navigtor_bar/bottom_navigator.dart';
import 'package:smartnote/utils/service/smartnote_api.dart';

class Auth with ChangeNotifier {
  Auth(this.api);

  final SmartNoteApi api;
  var _error = '';

  Future<void> login(String username, String password,context) async {
    username = username.trim();
    password = password.trim();
    final result = await api.authenticate(username,password);
    const genericError =
        'There was a problem logging in. Please try again later.';
    print(result.body);
    if (result.statusCode == 200) {
      try {
        Fluttertoast.showToast(
            msg: "Login Succesfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.green.shade600,
            textColor: Colors.white,
            fontSize: 16.0
        );
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomNavBar()));

      } catch (Exception) {
        _error = genericError;
      }
    } else if (result.statusCode == 401) {
      _error = 'Invalid password.';
      Fluttertoast.showToast(
          msg: _error,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red.shade600,
          textColor: Colors.white,
          fontSize: 16.0
      );
    } else if (result.statusCode == 404) {
      _error = 'User not found.';
      Fluttertoast.showToast(
          msg: _error,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red.shade600,
          textColor: Colors.white,
          fontSize: 16.0
      );
    } else if (result.type == APIResultType.connectionProblem) {
      _error = 'Please check your network connection.';
      Fluttertoast.showToast(
          msg: _error,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red.shade600,
          textColor: Colors.white,
          fontSize: 16.0
      );
    } else {
      _error = genericError;
      Fluttertoast.showToast(
          msg: _error,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red.shade600,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    notifyListeners();
  }
  Future<void> signup(String fname, String lname, String email,String username,String password,context) async {
    username = username.trim();
    password = password.trim();
    lname=lname.trim();
    fname=fname.trim();
    email=email.trim();
    final result = await api.singup(username,password,fname,lname,email);
    const genericError =
        'There was a problem logging in. Please try again later.';
    print(result.body);
    if (result.statusCode == 200) {
      try {
        Fluttertoast.showToast(
            msg: "Login Succesfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.green.shade600,
            textColor: Colors.white,
            fontSize: 16.0
        );
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomNavBar()));

      } catch (Exception) {
        _error = genericError;
      }
    } else if (result.statusCode == 401) {
      _error = 'Invalid password.';
      Fluttertoast.showToast(
          msg: _error,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red.shade600,
          textColor: Colors.white,
          fontSize: 16.0
      );
    } else if (result.statusCode == 404) {
      _error = 'User not found.';
      Fluttertoast.showToast(
          msg: _error,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red.shade600,
          textColor: Colors.white,
          fontSize: 16.0
      );
    } else if (result.type == APIResultType.connectionProblem) {
      _error = 'Please check your network connection.';
      Fluttertoast.showToast(
          msg: _error,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red.shade600,
          textColor: Colors.white,
          fontSize: 16.0
      );
    } else {
      _error = genericError;
      Fluttertoast.showToast(
          msg: _error,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red.shade600,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    notifyListeners();
  }
}
