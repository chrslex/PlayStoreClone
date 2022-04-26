import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../api/models/editProfileModel.dart';
import '../change_notifier/navigation.dart';

class EditProfileApp extends StatelessWidget {
  EditProfileApp({Key? key}) : super(key: key);
  TextEditingController nameController =
      TextEditingController();

  final _storage = const FlutterSecureStorage();
  Future<Map<String, String>> getAllValues() async {
    Map<String, String> allValues =
        await _storage.readAll();
    return allValues;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: FutureBuilder(
            future: getAllValues(),
            builder: (BuildContext context,
                AsyncSnapshot<Map<String, String>>
                    snapshot) {
              if (snapshot.hasData) {
                return Consumer<Navigation>(
                    builder: (context, navigation, _) {
                  nameController.text =
                      snapshot.data!["name"]!;
                  print(snapshot.data);
                  return (Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 10),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.center,
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const SizedBox(
                              height: 150,
                              width: 150,
                              child: CircleAvatar(
                                backgroundImage: AssetImage(
                                    'assets/images/profile1.png'),
                                radius: 50.0,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(snapshot.data!["name"]!,
                                style: GoogleFonts.poppins(
                                    textStyle:
                                        const TextStyle(
                                            fontWeight:
                                                FontWeight
                                                    .w500,
                                            fontSize: 20))),
                            const SizedBox(
                              height: 15,
                            ),
                            TextField(
                              controller: nameController,
                              decoration: InputDecoration(
                                border:
                                    const OutlineInputBorder(),
                                hintText: 'Edit Email',
                                labelText: 'Email',
                                prefixIcon:
                                    const Icon(Icons.mail),
                                suffixIcon: nameController
                                        .text.isEmpty
                                    ? Container(width: 0)
                                    : IconButton(
                                        icon: const Icon(
                                            Icons.close),
                                        onPressed: () {
                                          nameController
                                              .clear();
                                        },
                                      ),
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              crossAxisAlignment:
                                  CrossAxisAlignment.center,
                              mainAxisAlignment:
                                  MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  width: 100,
                                  height: 50,
                                  child: OutlinedButton(
                                      style: ButtonStyle(
                                          shape:
                                              MaterialStateProperty
                                                  .all(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius
                                                      .circular(
                                                          10.0),
                                            ),
                                          ),
                                          side: MaterialStateProperty.all(
                                              const BorderSide(
                                                  color: Colors
                                                      .redAccent,
                                                  width:
                                                      1.0))),
                                      onPressed: () {
                                        navigation.setPage =
                                            "Profile Page";
                                      },
                                      child: Text(
                                        "Cancel",
                                        style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                                fontWeight:
                                                    FontWeight
                                                        .w500,
                                                fontSize:
                                                    16,
                                                color: Colors
                                                    .redAccent)),
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
                                          backgroundColor:
                                              MaterialStateProperty.all<
                                                      Color>(
                                                  Colors
                                                      .green),
                                          shape:
                                              MaterialStateProperty
                                                  .all(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius
                                                      .circular(
                                                          10.0),
                                            ),
                                          ),
                                          side: MaterialStateProperty.all(
                                              const BorderSide(
                                                  color: Colors
                                                      .green,
                                                  width:
                                                      1.0))),
                                      onPressed: () {
                                        EditProfile
                                            .setProfile(
                                          snapshot
                                              .data!["id"]!,
                                          nameController
                                              .text,
                                          snapshot.data![
                                              "token"]!,
                                        ).then((value) => {
                                              if (!RegExp(
                                                      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                                  .hasMatch(
                                                      nameController
                                                          .text))
                                                {
                                                  AwesomeDialog(
                                                          context: context,
                                                          animType: AnimType.SCALE,
                                                          dialogType: DialogType.ERROR,
                                                          body: const Padding(
                                                              padding: EdgeInsets.all(15),
                                                              child: Center(
                                                                child: Text(
                                                                  'Email not valid',
                                                                  style: TextStyle(fontStyle: FontStyle.italic),
                                                                ),
                                                              )),
                                                          btnOkOnPress: () {},
                                                          btnOkColor: Colors.red)
                                                      .show()
                                                }
                                              else
                                                {
                                                  if (value
                                                          .code !=
                                                      200)
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
                                                                      style: TextStyle(fontStyle: FontStyle.italic),
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
                                                                  padding: const EdgeInsets.all(15),
                                                                  child: Center(
                                                                    child: Text(
                                                                      'Success to edit name',
                                                                      style: GoogleFonts.poppins(textStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.green)),
                                                                    ),
                                                                  )),
                                                              btnOkOnPress: () {
                                                                navigation.setPage = "Profile Page";
                                                                navigation.setName = nameController.text;
                                                              },
                                                              btnOkColor: Colors.green)
                                                          .show()
                                                    }
                                                }
                                            });
                                      },
                                      child: Text(
                                        "Save",
                                        style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                                fontWeight:
                                                    FontWeight
                                                        .w500,
                                                fontSize:
                                                    16,
                                                color: Colors
                                                    .white)),
                                      )),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ));
                });
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
