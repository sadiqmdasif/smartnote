import 'package:flutter/material.dart';
import 'package:smartnote/core/component/custom_buttom.dart';
import 'package:smartnote/core/component/custom_text_field.dart';
import 'package:smartnote/core/component/custom_text_from_field.dart';
import 'package:smartnote/core/screen/bottom_navigtor_bar/bottom_navigator.dart';
import 'package:smartnote/core/screen/individual/registration.dart';
import 'package:smartnote/core/screen/profile/proifle.dart';
import 'package:smartnote/utils/theme/theme.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();
  var _isPasswordHide = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 150,
                width: 350,
                child: Image.asset("assets/image/smartnote.jpeg"),
              ),
              const SizedBox(
                height: CustomSpacing.medium,
              ),
              const Text(
                "Sign In",
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              const SizedBox(
                height: CustomSpacing.medium,
              ),
              const Text(
                "Hi there! Nice to see you again",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(
                height: CustomSpacing.medium,
              ),
              const Text("Email",
                  style: TextStyle(fontSize: 14, color: CustomColors.primary)),
              TextFormField(
                  key: const Key('email'),
                  controller: _userController,
                  decoration:
                      const InputDecoration(hintText: "example@gmail.com")),
              const SizedBox(
                height: CustomSpacing.medium,
              ),
              const Text("Password",
                  style: TextStyle(fontSize: 14, color: CustomColors.primary)),
              TextFormField(
                key: const Key('password'),
                controller: _passwordController,
                obscureText: _isPasswordHide,
                decoration: InputDecoration(
                  hintText: "*******",
                  suffix: IconButton(
                      onPressed: () {
                        setState(() {
                          _isPasswordHide = !_isPasswordHide;
                        });
                      },
                      icon: Icon(_isPasswordHide
                          ? Icons.visibility
                          : Icons.visibility_off)),
                ),
              ),
              const SizedBox(
                height: CustomSpacing.large,
              ),
              CustomButton.small(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => BottomNavBar()));
                },
                text: "Sign in",
              ),
              const SizedBox(
                height: CustomSpacing.large,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Forgot Password"),
                  FlatButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Registration()));
                    },
                    child: const Text(
                      "Sign up",
                      style: TextStyle(
                          color: CustomColors.primary,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
