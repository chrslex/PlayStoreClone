// import 'package:flutter/material.dart';

// class LoginWidget extends StatelessWidget {
//   final String email;
//   final String password;

//   const LoginWidget({Key? key, required this.email, required this.password}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//     padding: EdgeInsets.symmetric(vertical: 25),
//     width: double.infinity,
//     child: RaisedButton(
//       elevation: 5,
//       onPressed: () {
//         print("LOGIN");
//         print("Email : " + this.email);
//         print("Password : " + this.password);
//       },
//       padding: EdgeInsets.all(15),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       color: Colors.white,
//       child: Text('LOGIN',
//           style: TextStyle(
//               color: Color(0xff5ac18e),
//               fontSize: 18,
//               fontWeight: FontWeight.bold)),
//     ),
//   );
//   }
// }

// class LoginWidget extends StatefulWidget {
//   final String email;
//   final String password;

//   const LoginWidget({Key? key, required this.email, required this.password}) : super(key: key);

//   @override
//   _LoginWidgetState createState() => _LoginWidgetState();
// }

// class _LoginWidgetState extends State<LoginWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
