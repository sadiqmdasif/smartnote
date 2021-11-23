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

  // Future<void> login(String username, String password) async {
  //   username = username.trim();
  //   password = password.trim();
  //   print(username);
  //   final result = await api.post("/Account/Login",body: jsonEncode({'userEmail': username, 'userPassword': password}),);
  //   print(result.body);
  //   notifyListeners();
  // }
  Future<void> login(String username, String password, context) async {
    username = username.trim();
    password = password.trim();
    print(username);
    final result = await http.post(Uri.parse("http://103.192.157.58:4006/api/Account/Login"),
        body: jsonEncode({'userEmail': username, 'userPassword': password},),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        }
    );
    print(result.body);
    if(result.statusCode==200){
      Fluttertoast.showToast(
          msg: "Login Succesfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomNavBar()));
    }


    notifyListeners();
  }


  Future signup(
      {required String fname,
        required String lname,
      required String email,
      required String username,
      required String password,
      context
      }) async {
   var result = await http.post(Uri.parse("http://103.192.157.58:4006/api/Account/Register"), body:
      jsonEncode({
        "id": 0,
        "createdAt": "2021-11-23T09:52:35.054Z",
        "updatedAt": "2021-11-23T09:52:35.054Z",
        "deletedAt": "2021-11-23T09:52:35.054Z",
        "createdBy": 0,
        "modifiedBy": 0,
        "deletedBy": 0,
        "isDeleted": true,
        "isActive": true,
        "firstName": fname,
        "lastName": lname,
        "roleName": "string",
        "userName": username,
        "userEmail": email,
        "userPassword": password,
        "imageUrl": "string",
        "userPhone": "string",
        "userGroup": "string",
        "userStatus": true,
        "pmsGroupID": 0,
        "groupID": 0,
        "dob": "2021-11-23T09:52:35.055Z"
      }),
       headers: {
         'Content-Type': 'application/json; charset=UTF-8',
       }
   );
   print(result.body);
   if(result.statusCode==200){
     Fluttertoast.showToast(
         msg: "Registration Succesfully",
         toastLength: Toast.LENGTH_SHORT,
         gravity: ToastGravity.CENTER,
         timeInSecForIosWeb: 1,
         backgroundColor: Colors.red,
         textColor: Colors.white,
         fontSize: 16.0
     );
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomNavBar()));
   }

    notifyListeners();

    return result;
  }
}
