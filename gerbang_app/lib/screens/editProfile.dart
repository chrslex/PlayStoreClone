import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api/models/editProfileModel.dart';
import '../change_notifier/navigation.dart';

class EditProfileApp extends StatelessWidget {
  EditProfileApp({Key? key}) : super(key: key);
  TextEditingController nameController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Material(

      child: SizedBox(
                width: double.infinity,
                height: 350.0,
                child: Consumer<Navigation> (
                    builder: (context, navigation, _) {
                      nameController.text = navigation.name;
                      return (
                          Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const CircleAvatar(
                        backgroundImage: AssetImage('build/flutter_assets/build/flutter_assets/images/profile.png'),
                        radius: 50.0,
                      ),
                      TextFormField(
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          border: InputBorder.none
                        ),
                        controller: nameController,
                        style: const TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 30.0,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        navigation.email,
                        style: const TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 14.0,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                OutlinedButton(
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                        ),
                                        side: MaterialStateProperty.all(
                                            const BorderSide(
                                                color: Colors.green,
                                                width: 1.0
                                            )
                                        )
                                    ),
                                    onPressed: () {
                                      navigation.setPage = "Profile Page";
                                    },
                                    child: const Text(
                                      "Cancel",
                                      style: TextStyle(
                                        fontFamily: 'Arial',
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                    )
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                OutlinedButton(
                                    style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                        ),
                                        side: MaterialStateProperty.all(
                                            const BorderSide(
                                                color: Colors.green,
                                                width: 1.0
                                            )
                                        )
                                    ),
                                    onPressed: () {
                                      EditProfile.setProfile(
                                          navigation.id,
                                          nameController.text,
                                          navigation.token,
                                      ).then((value) =>
                                            {
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
                                                              'Fail to save name',
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
                                                    navigation.setName = value.name,
                                                    navigation.setPage = "Profile Page"
                                                  }
                                            });
                                      },
                                      child: const Text(
                                          "Save",
                                          style: TextStyle(
                                            fontFamily: 'Arial',
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        )
                                )
                              ],
                            ),
                    ],
                  )
                )
                );
            }
          )
      )
    );
  }
}
