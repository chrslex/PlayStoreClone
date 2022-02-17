import 'package:flutter/material.dart';

class EditProfileApp extends StatelessWidget {
  const EditProfileApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.green, Colors.greenAccent]
                  )
              ),
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
                        backgroundImage: AssetImage('build/flutter_assets/images/keqing.png'),
                        radius: 50.0,
                      ),
                      const SizedBox(
                        height: 20.0,
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
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Text(
                        "alice@gmail.com",
                        style: TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 14.0,
                          color: Colors.white,
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
                                          color: Colors.white,
                                          width: 1.0
                                      )
                                  )
                              ),
                              onPressed: () {  },
                              child: const Text(
                                "Cancel",
                                style: TextStyle(
                                  fontFamily: 'Arial',
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              )
                          ),
                            const SizedBox(
                              width: 10.0,
                            ),
                          OutlinedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  side: MaterialStateProperty.all(
                                      const BorderSide(
                                          color: Colors.white,
                                          width: 1.0
                                      )
                                  )
                              ),
                              onPressed: () {  },
                              child: const Text(
                                "Save",
                                style: TextStyle(
                                  fontFamily: 'Arial',
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.greenAccent,
                                ),
                              )
                          )
                        ]
                      )

                    ],
                  ),
                ),
              )
          )
    );
  }
}
