import 'package:flutter/material.dart';
import 'package:gerbang_app/api/models/LoginModel.dart';
import 'package:gerbang_app/profilePage/editProfile.dart';
import 'package:gerbang_app/profilePage/profilePage.dart';
import 'package:gerbang_app/screens/loginScreen.dart';
import 'package:gerbang_app/screens/registerScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Login User',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
