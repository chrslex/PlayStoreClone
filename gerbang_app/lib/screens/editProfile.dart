import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../change_notifier/navigation.dart';

class EditProfileApp extends StatelessWidget {
  const EditProfileApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
                width: double.infinity,
                height: 350.0,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const CircleAvatar(
                        backgroundImage: AssetImage('build/flutter_assets/images/profile.jpg'),
                        radius: 50.0,
                      ),
                      TextFormField(
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          border: InputBorder.none
                        ),
                        controller: TextEditingController(
                            text: "Alice James",
                        ),
                        style: const TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 30.0,
                          color: Colors.black,
                        ),
                      ),
                      const Text(
                        "alice@gmail.com",
                        style: TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 14.0,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Consumer<Navigation> (
                          builder: (context, navigation, _) => Row(
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
                                      navigation.setPage = "Profile Page";
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
                              ]
                          )

                      )

                    ],
                  ),
                ),
              )
    );
  }
}
