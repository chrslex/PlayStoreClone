import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gerbang_app/api/models/LoginModel.dart';
import 'package:gerbang_app/widget/auth/email_widget.dart';
import 'package:gerbang_app/widget/auth/password_widget.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

Widget buildForgotPassBtn() {
  return Container(
    alignment: Alignment.centerRight,
    child: TextButton(
      onPressed: () => print('Forgot Password Button Pressed'),
      style: TextButton.styleFrom(
          padding: const EdgeInsets.fromLTRB(0, 15, 0, 15)),
      child: const Text('Forgot Password ?',
          style: TextStyle(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
    ),
  );
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 25),
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(15),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                primary: Colors.white,
                                shadowColor: Colors.amber,
                                onPrimary: Colors.black87,
                                onSurface: Colors.amber),
                            onPressed: () {
                              Login.loginUser(emailController.text,
                                      passwordController.text)
                                  .then((value) => {
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
                                        else
                                          {
                                            AwesomeDialog(
                                                    context: context,
                                                    animType: AnimType.SCALE,
                                                    dialogType:
                                                        DialogType.SUCCES,
                                                    body: const Padding(
                                                        padding:
                                                            EdgeInsets.all(15),
                                                        child: Center(
                                                          child: Text(
                                                            'Login successfull',
                                                            style: TextStyle(
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic),
                                                          ),
                                                        )),
                                                    btnOkOnPress: () {},
                                                    btnOkColor: Colors.green)
                                                .show()
                                          }
                                      });
                            },
                            child: const Text('LOGIN',
                                style: TextStyle(
                                    color: Color(0xff5ac18e),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                          ),
                        )
                      ],
                    ),
                  ))
            ]))));
  }
}
