import 'package:flutter/material.dart';
import 'package:gerbang_app/screens/loginScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login User',
      debugShowCheckedModeBanner: false,
      home: LoginScreen()
    );
  }
}
