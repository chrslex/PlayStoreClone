import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'editProfile.dart';
import '../change_notifier/navigation.dart';

class ProfileApp extends StatelessWidget {
  const ProfileApp({Key? key}) : super(key: key);
  static const TextStyle _textStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
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
                    builder: (context, navigation, _) =>
                        SizedBox(
                          width: double.infinity,
                          height: 350.0,
                          child: Center(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.center,
                              mainAxisAlignment:
                                  MainAxisAlignment.center,
                              children: <Widget>[
                                const CircleAvatar(
                                  backgroundImage: AssetImage(
                                      'assets/images/profile1.png'),
                                  radius: 75.0,
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  snapshot.data!["name"]!,
                                  style: const TextStyle(
                                    fontFamily: 'Arial',
                                    fontSize: 26.0,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  snapshot.data!["email"]!,
                                  style: const TextStyle(
                                    fontFamily: 'Arial',
                                    fontSize: 14.0,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                OutlinedButton(
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
                                                    .white,
                                                width:
                                                    1.0)),
                                        backgroundColor:
                                            MaterialStateProperty
                                                .all<Color>(
                                                    Colors
                                                        .green)),
                                    onPressed: () {
                                      navigation.setPage =
                                          "Edit Profile";
                                    },
                                    child: const Text(
                                      "Edit Name",
                                      style: TextStyle(
                                        fontFamily: 'Arial',
                                        fontSize: 16.0,
                                        fontWeight:
                                            FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        ));
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
