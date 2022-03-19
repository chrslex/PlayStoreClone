import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gerbang_app/screens/editProfile.dart';
import 'package:gerbang_app/screens/profilePage.dart';
import 'package:gerbang_app/screens/loginScreen.dart';
import 'package:gerbang_app/screens/registerScreen.dart';
import 'change_notifier/navigation.dart';
import 'widget/navbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider<Navigation>(
        create: (context) => Navigation(),
        child: Consumer<Navigation>(
          builder: (context, navigation, _) {
            if (navigation.page == "Login") {
              return LoginScreen();
            }
            else if (navigation.page == "Register") {
              return RegisterScreen();
            }
            else {
              return MyHomePage();
            }
          }
        )
      )
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    const Text(
      'Index 1: Apps',
      style: optionStyle,
    ),
    const Text(
      'Index 2: Books',
      style: optionStyle,
    ),
    Consumer<Navigation>(
        builder: (context, navigation, _) {
          if (navigation.page == "Edit Profile"){
            return EditProfileApp();
          }
          else {
            return ProfileApp();
          }
        }
    )
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerbang'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.apps),
            label: 'Apps',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Books',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),
    );
  }
}

