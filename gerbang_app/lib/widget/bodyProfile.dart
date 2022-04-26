import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gerbang_app/change_notifier/navigation.dart';
import 'package:gerbang_app/widget/profilePictureWidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BodyProfile extends StatefulWidget {
  const BodyProfile({Key? key}) : super(key: key);

  @override
  State<BodyProfile> createState() => _BodyProfileState();
}

class _BodyProfileState extends State<BodyProfile> {
  final _storage = const FlutterSecureStorage();

  Future<Map<String, String>> getAllValues() async {
    Map<String, String> allValues =
        await _storage.readAll();
    return allValues;
  }

  Future<void> deleteAllSecureStorageInfo() async {
    await _storage.deleteAll();
    await _storage.write(
        key: "Log In Status", value: "false");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getAllValues(),
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, String>> snapshot) {
          if (snapshot.hasData) {
            return Consumer<Navigation>(
              builder: (context, navigation, _) => Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 0, vertical: 50),
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
                          navigation.setPage =
                              "Edit Profile";
                          navigation.setName =
                              snapshot.data!["name"]!;
                        }),
                    ProfileMenu(
                        icon: 'assets/svg/logout.svg',
                        text: 'Logout',
                        press: () async {
                          await deleteAllSecureStorageInfo().then((value) => 
                          navigation.setPage = "Login");
                        }),
                  ],
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
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
      padding: const EdgeInsets.symmetric(
          horizontal: 40, vertical: 10),
      child: FlatButton(
          padding: const EdgeInsets.symmetric(
              horizontal: 30, vertical: 15),
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
                              fontWeight: FontWeight.w700,
                              fontSize: 14)))),
              const Icon(Icons.arrow_forward_ios)
            ],
          )),
    );
  }
}
