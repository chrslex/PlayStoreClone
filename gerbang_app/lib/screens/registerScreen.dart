import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gerbang_app/api/models/RegisterModel.dart';
import 'package:gerbang_app/widget/auth/email_widget.dart';
import 'package:gerbang_app/widget/auth/password_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

Widget buildName() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
            ]),
        height: 60,
        child: const TextField(
          style: TextStyle(color: Colors.black87),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 12),
            prefixIcon: Icon(
              Icons.account_circle,
              color: Color(0xff5ac18e),
            ),
            hintText: 'Name',
            hintStyle: TextStyle(color: Colors.black54),
          ),
        ),
      )
    ],
  );
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: GestureDetector(
                child: Stack(children: <Widget>[
              Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                        Color(0x665ac18e),
                        Color(0x995ac18e),
                        Color(0xcc5ac18e),
                        Color(0xff5ac18e),
                      ])),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 120),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'Sign Up',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        EmailWidget(controller: emailController),
                        const SizedBox(
                          height: 20,
                        ),
                        buildName(),
                        const SizedBox(
                          height: 20,
                        ),
                        PasswordWidget(
                          controller: passwordController,
                          placeholder: 'Enter password',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        PasswordWidget(
                          controller: confirmPasswordController,
                          placeholder: 'Enter confirm password',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 25),
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => {
                              if (confirmPasswordController.text ==
                                  passwordController.text)
                                {
                                  Register.registerUser(
                                          nameController.text,
                                          emailController.text,
                                          passwordController.text,
                                          'user')
                                      .then((value) => {
                                            AwesomeDialog(
                                                    context: context,
                                                    animType: AnimType.SCALE,
                                                    dialogType:
                                                        value.code == 201
                                                            ? DialogType.SUCCES
                                                            : DialogType.ERROR,
                                                    body: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(15),
                                                        child: Center(
                                                          child: Text(
                                                            value.code == 201
                                                                ? 'Successfully registered user'
                                                                : 'Email already registered',
                                                            style: const TextStyle(
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic),
                                                          ),
                                                        )),
                                                    btnOkOnPress: () {},
                                                    btnOkColor:
                                                        value.code == 201
                                                            ? Colors.green
                                                            : Colors.red)
                                                .show()
                                          })
                                }
                              else
                                {
                                  AwesomeDialog(
                                          context: context,
                                          animType: AnimType.SCALE,
                                          dialogType: DialogType.ERROR,
                                          body: const Padding(
                                              padding: EdgeInsets.all(15),
                                              child: Center(
                                                child: Text(
                                                  'Password not match',
                                                  style: TextStyle(
                                                      fontStyle:
                                                          FontStyle.italic),
                                                ),
                                              )),
                                          btnOkOnPress: () {},
                                          btnOkColor: Colors.red)
                                      .show()
                                },
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(15),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              primary: Colors.white,
                            ),
                            child: const Text('Register',
                                style: TextStyle(
                                    color: Color(0xff5ac18e),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                  ))
            ]))));
  }
}
