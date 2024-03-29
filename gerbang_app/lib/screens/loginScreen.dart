import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gerbang_app/api/models/LoginModel.dart';
import 'package:gerbang_app/widget/auth/email_widget.dart';
import 'package:gerbang_app/widget/auth/password_widget.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../change_notifier/navigation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

Widget buildForgotPassBtn() {
  return Container(
    alignment: Alignment.centerRight,
    child: Consumer<Navigation> (
      builder: (context, navigation, _) => TextButton(
        onPressed: () {
          navigation.setPage = "Register";
        },
        style: TextButton.styleFrom(
            padding: const EdgeInsets.fromLTRB(0, 15, 0, 15)),
        child: const Text("Don't have an account?",
            style: TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
      ),
    )
  );
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _storage = const FlutterSecureStorage();
  GlobalKey<FormState> _form = GlobalKey<FormState>();

  void validate(){
    _form.currentState!.validate();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: GestureDetector(
                child: Stack(children: <Widget>[
              Form(
                key: _form,
                child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.green, Colors.greenAccent])),
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 120),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            'Sign In',
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
                          PasswordWidget(
                            controller: passwordController,
                            placeholder: 'Enter password',
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          buildForgotPassBtn(),
                          Consumer<Navigation> (
                            builder: (context, navigation, _) =>
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 25),
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.all(15),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                15)),
                                        primary: Colors.white,
                                        shadowColor: Colors.amber,
                                        onPrimary: Colors.black87,
                                        onSurface: Colors.amber),
                                    onPressed: () {
                                      Login.loginUser(emailController.text,
                                          passwordController.text)
                                          .then((value) async =>
                                      {
                                        if (value.code != 200)
                                          {
                                            AwesomeDialog(
                                                context: context,
                                                animType: AnimType.SCALE,
                                                dialogType:
                                                DialogType.ERROR,
                                                body: const Padding(
                                                    padding:
                                                    EdgeInsets.all(15),
                                                    child: Center(
                                                      child: Text(
                                                        'Invalid Email or Password',
                                                        style: TextStyle(
                                                            fontStyle:
                                                            FontStyle
                                                                .italic),
                                                      ),
                                                    )),
                                                btnOkOnPress: () {},
                                                btnOkColor: Colors.red)
                                                .show()
                                          }
                                        else {
                                          navigation.setId = value.id,
                                          await _storage.write(key: "id", value: value.id),
                                          navigation.setName = value.name,
                                          await _storage.write(key: "name", value: value.name),
                                          navigation.setEmail = value.email,
                                          await _storage.write(key: "email", value: value.email),
                                          navigation.setToken = value.token,
                                          await _storage.write(key: "token", value: value.token),
                                          await _storage.write(key: "Log In Status", value: "true"),
                                          navigation.setPage = "Home Page",
                                          navigation.selectedIndex = 0,
                                          if (value.name == "") {
                                            navigation.setName = value.email,
                                            await _storage.write(key: "name", value: value.email),
                                            
                                          }
                                        },
                                      });
                                    },
                                    child: const Text('LOGIN',
                                        style: TextStyle(
                                            color: Color(0xff5ac18e),
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                )
                          )
                        ],
                      ),
                    )),
              )
            ]))));
  }
}
