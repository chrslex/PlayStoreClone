import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

Widget buildEmail() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text('Email',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
      SizedBox(height: 10),
      Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
            ]),
        height: 60,
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(color: Colors.black87),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 12),
            prefixIcon: Icon(
              Icons.email,
              color: Color(0xff5ac18e),
            ),
            hintText: 'Enter your email',
            hintStyle: TextStyle(color: Colors.black54),
          ),
        ),
      )
    ],
  );
}

Widget buildPassword() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text('Password',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
      SizedBox(height: 10),
      Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
            ]),
        height: 60,
        child: TextField(
          obscureText: true,
          style: TextStyle(color: Colors.black87),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 12),
            prefixIcon: Icon(
              Icons.lock,
              color: Color(0xff5ac18e),
            ),
            hintText: 'Enter your password',
            hintStyle: TextStyle(color: Colors.black54),
          ),
        ),
      )
    ],
  );
}

Widget buildForgotPassBtn() {
  return Container(
    alignment: Alignment.centerRight,
    child: FlatButton(
      onPressed: () => print('Forgot Password Button Pressed'),
      padding: EdgeInsets.only(right: 0),
      child: Text('Forgot Password ?',
          style: TextStyle(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
    ),
  );
}

Widget buildLoginBtn() {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 25),
    width: double.infinity,
    child: RaisedButton(
      elevation: 5,
      onPressed: () => print("Login Pressed"),
      padding: EdgeInsets.all(15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.white,
      child: Text('LOGIN', style: TextStyle(color: Color(0xff5ac18e), fontSize: 18, fontWeight: FontWeight.bold)),
    ),
  );
}

class _LoginScreenState extends State<LoginScreen> {
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
                  decoration: BoxDecoration(
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
                    physics: AlwaysScrollableScrollPhysics(),
                    padding:
                        EdgeInsets.symmetric(horizontal: 25, vertical: 120),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Sign In',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        buildEmail(),
                        SizedBox(
                          height: 20,
                        ),
                        buildPassword(),
                        SizedBox(
                          height: 10,
                        ),
                        buildForgotPassBtn(),
                        buildLoginBtn()
                      ],
                    ),
                  ))
            ]))));
  }
}
