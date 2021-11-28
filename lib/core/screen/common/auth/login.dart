import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartnote/core/component/custom_buttom.dart';
import 'package:smartnote/core/provider/data/auth.dart';
import 'package:smartnote/core/screen/individual/registration.dart';
import 'package:smartnote/utils/theme/theme.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _userController = TextEditingController(text: 'sheble@gmail.com');
  final _passwordController = TextEditingController(text: 'sheble1234');
  var _isPasswordHide = true;
  final _formKey = GlobalKey<FormState>();
 Future? _login;
  @override
  Widget build(BuildContext context) {
 final authData = Provider.of<Auth>(context);
     login() {
      setState(() {
        _login = authData.login(
            _userController.text, _passwordController.text,context
        )
          ..then((_) {});
      });
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
            Form(
              key:_formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: CustomSpacing.medium,
                  ),
                  const Text("Email",
                      style: TextStyle(fontSize: 14, color: CustomColors.primary)),
                  TextFormField(
                      validator: (value) =>
                      value == null || value.isEmpty
                          ? 'Useremail is required'
                          : null,
                      key: const Key('email'),
                      controller: _userController,
                      autofillHints: [AutofillHints.email],
                      decoration:
                      const InputDecoration(hintText: "example@gmail.com")),
                  const SizedBox(
                    height: CustomSpacing.medium,
                  ),
                  const Text("Password",
                      style: TextStyle(fontSize: 14, color: CustomColors.primary)),
                  TextFormField(
                    key: const Key('password'),
                    validator: (value) =>
                    value == null || value.isEmpty
                        ? 'Password is required'
                        : null,
                    controller: _passwordController,
                    autofillHints: [AutofillHints.password],
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
                ],
              ),
            ),

                FutureBuilder<void>(
                    future: _login,
                    builder: (ctx, snapshot) {
                      return CustomButton(
                        key: Key("Sign in"),
                        text: 'Sign in',
                        onPressed: () {
                          if (_formKey.currentState != null &&
                              _formKey.currentState!.validate() &&
                              !(snapshot.connectionState ==
                                  ConnectionState.waiting)) {
                            login();
                          }
                        },
                      );
                    }),
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
      ),
    );
  }
}
