import 'package:flutter/material.dart';
import 'package:smartnote/core/screen/common/auth/login.dart';
import 'package:smartnote/utils/theme/theme.dart';

void main() {
  runApp(
    const MyApp()
  );
}
class MyApp extends StatelessWidget{
  const MyApp({Key? key}):super(key:key);

  @override
  Widget build (BuildContext context){
  return MaterialApp(
  debugShowCheckedModeBanner: false,
  title: "SmartNote",
  theme: CustomTheme.lightTheme,
    home: Login(),
  );
  }
}