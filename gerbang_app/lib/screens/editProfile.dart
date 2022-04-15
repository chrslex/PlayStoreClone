import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../api/models/editProfileModel.dart';
import '../change_notifier/navigation.dart';

class EditProfileApp extends StatelessWidget {
  EditProfileApp({Key? key}) : super(key: key);
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Consumer<Navigation>(builder: (context, navigation, _) {
      nameController.text = navigation.name;
      return (Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(
                  height: 150,
                  width: 150,
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/profile1.png'),
                    radius: 50.0,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(nameController.text,
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20))),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Edit Email',
                    labelText: 'Email',
                    prefixIcon: const Icon(Icons.mail),
                    suffixIcon: nameController.text.isEmpty
                        ? Container(width: 0)
                        : IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              nameController.clear();
                            },
                          ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 100,
                      height: 50,
                      child: OutlinedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              side: MaterialStateProperty.all(const BorderSide(
                                  color: Colors.redAccent, width: 1.0))),
                          onPressed: () {
                            navigation.setPage = "Profile Page";
                          },
                          child: Text(
                            "Cancel",
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Colors.redAccent)),
                          )),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    SizedBox(
                      width: 100,
                      height: 50,
                      child: OutlinedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.green),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              side: MaterialStateProperty.all(const BorderSide(
                                  color: Colors.green, width: 1.0))),
                          onPressed: () {
                            EditProfile.setProfile(
                              navigation.id,
                              nameController.text,
                              navigation.token,
                            ).then((value) => {
                                  if (value.code != 200)
                                    {
                                      AwesomeDialog(
                                              context: context,
                                              animType: AnimType.SCALE,
                                              dialogType: DialogType.ERROR,
                                              body: const Padding(
                                                  padding: EdgeInsets.all(15),
                                                  child: Center(
                                                    child: Text(
                                                      'Fail to save name',
                                                      style: TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic),
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
                                              dialogType: DialogType.SUCCES,
                                              body: Padding(
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  child: Center(
                                                    child: Text(
                                                      'Success to edit name',
                                                      style: GoogleFonts.poppins(
                                                          textStyle:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .green)),
                                                    ),
                                                  )),
                                              btnOkOnPress: () {
                                                navigation.setPage =
                                                    "Profile Page";
                                                navigation.setName = value.name;
                                              },
                                              btnOkColor: Colors.green)
                                          .show()
                                    }
                                });
                          },
                          child: Text(
                            "Save",
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Colors.white)),
                          )),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ));
    }));
  }
}
