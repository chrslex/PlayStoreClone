import 'package:flutter/material.dart';
import 'package:gerbang_app/change_notifier/navigation.dart';
import 'package:gerbang_app/widget/bodyProfile.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Navigation>(
      builder: (context, navigation, _) => const Scaffold(
        body: BodyProfile(),
      ),
    );
  }
}
