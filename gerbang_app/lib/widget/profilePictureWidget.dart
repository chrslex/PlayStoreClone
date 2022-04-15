import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
        height: 150,
        width: 150,
        child: CircleAvatar(
          backgroundImage: AssetImage('assets/images/profile1.png'),
        ));
  }
}
