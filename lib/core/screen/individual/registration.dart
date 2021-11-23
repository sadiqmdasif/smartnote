import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartnote/core/component/custom_buttom.dart';
import 'package:smartnote/core/component/custom_text_field.dart';
import 'package:smartnote/core/component/custom_text_from_field.dart';
import 'package:smartnote/core/provider/data/auth.dart';
import 'package:smartnote/core/screen/common/auth/login.dart';
import 'package:smartnote/utils/theme/theme.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneNoController = TextEditingController();
  final _emailController = TextEditingController();

  var _isPasswordHide = true;
  var _isAgreed = false;
  Future? _siginup;


  void getData() {
    _usernameController.text;
  }

  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<Auth>(context);
    singup() {
      setState(() {
        _siginup = authData.signup(
            email:_emailController.text,
           fname: _fullNameController.text,
            lname:_fullNameController.text,
            username:_usernameController.text,
            password:_passwordController.text,
            context:context)
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
                const SizedBox(
                  height: CustomSpacing.medium,
                ),
                const Text(
                  "Sign Up",
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: CustomSpacing.medium,
                      ),
                      const Text("Full Name",
                          style: TextStyle(
                              fontSize: 14, color: CustomColors.primary)),
                      TextFormField(
                          key: const Key('full_name'),
                          controller: _fullNameController,
                          decoration:
                              const InputDecoration(hintText: "Your full name")),
                      const SizedBox(
                        height: CustomSpacing.medium,
                      ),
                      const Text("Username",
                          style: TextStyle(
                              fontSize: 14, color: CustomColors.primary)),
                      TextFormField(
                          key: const Key('username'),
                          controller: _usernameController,
                          decoration:
                              const InputDecoration(hintText: "Enter username")),
                      const SizedBox(
                        height: CustomSpacing.medium,
                      ),
                      const Text("Address",
                          style: TextStyle(
                              fontSize: 14, color: CustomColors.primary)),
                      TextFormField(
                          key: const Key('address'),
                          controller: _addressController,
                          decoration: const InputDecoration(
                              hintText: "Enter your address")),
                      const SizedBox(
                        height: CustomSpacing.medium,
                      ),
                      const Text("Phone No",
                          style: TextStyle(
                              fontSize: 14, color: CustomColors.primary)),
                      TextFormField(
                          key: const Key('phone_no'),
                          controller: _phoneNoController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            hintText: "Enter phone no",
                          )),
                      const SizedBox(
                        height: CustomSpacing.medium,
                      ),
                      const Text("Email",
                          style: TextStyle(
                              fontSize: 14, color: CustomColors.primary)),
                      TextFormField(
                          key: const Key('email'),
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          decoration: const InputDecoration(
                              hintText: "example@email.com")),
                      const SizedBox(
                        height: CustomSpacing.medium,
                      ),
                      const Text("Password",
                          style: TextStyle(
                              fontSize: 14, color: CustomColors.primary)),
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
                        height: CustomSpacing.medium,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                              value: _isAgreed,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isAgreed = value!;
                                });
                              }),
                          const Text(
                              "I agree to the Terms of Services and Privacy.",
                          maxLines: 2,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: CustomSpacing.large,
                      ),
                      CustomButton.small(
                        onPressed: () {
                          singup();
                        },
                        text: "Continue",
                      ),
                      const SizedBox(
                        height: CustomSpacing.large,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text("Already have an account?"),
                          FlatButton(
                              onPressed: () {
                                getData();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login()));
                              },
                              child: const Text(
                                "Sign in",
                                style: TextStyle(
                                    color: CustomColors.primary,
                                    fontWeight: FontWeight.bold),
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: CustomSpacing.large,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
