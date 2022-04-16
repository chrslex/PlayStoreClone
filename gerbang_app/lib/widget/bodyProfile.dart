import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gerbang_app/change_notifier/navigation.dart';
import 'package:gerbang_app/widget/profilePictureWidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BodyProfile extends StatelessWidget {
  const BodyProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Navigation>(
      builder: (context, navigation, _) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 50),
        child: Column(
          children: [
            const ProfilePicture(),
            const SizedBox(
              height: 20,
            ),
            ProfileMenu(
                icon: 'assets/svg/user.svg',
                text: 'My Account',
                press: () {
                  navigation.setPage = "Edit Profile";
                  navigation.setName = navigation.name;
                }),
            ProfileMenu(
                icon: 'assets/svg/logout.svg',
                text: 'Logout',
                press: () {
                  navigation.setPage = "Login";
                }),
          ],
        ),
      ),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final String text, icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: FlatButton(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          color: const Color(0xFFF1F1F9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          onPressed: press,
          child: Row(
            children: [
              SvgPicture.asset(
                icon,
                height: 30,
                width: 30,
              ),
              const SizedBox(width: 20),
              Expanded(
                  child: Text(text,
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 14)))),
              const Icon(Icons.arrow_forward_ios)
            ],
          )),
    );
  }
}
