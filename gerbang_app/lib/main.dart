import 'package:flutter/material.dart';
import 'package:gerbang_app/api/models/bookModel.dart';
import 'package:gerbang_app/screens/bookList.dart';
import 'package:gerbang_app/screens/experimentalAppList.dart';
import 'package:gerbang_app/screens/experimentalBookList.dart';
import 'package:gerbang_app/screens/exploreAllProducts.dart';
import 'package:gerbang_app/screens/productDetails.dart';
import 'package:gerbang_app/widget/appBar.dart';
import 'package:provider/provider.dart';
import 'package:gerbang_app/screens/editProfile.dart';
import 'package:gerbang_app/screens/profilePage.dart';
import 'package:gerbang_app/screens/appList.dart';
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
              } else if (navigation.page == "Register") {
                return RegisterScreen();
              } else {
                return MyHomePage();
              }
            })));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() =>
      _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    Consumer<Navigation>(builder: (context, navigation, _) {
      if (navigation.page == "Product Detail App") {
        return ProductDetail();
      } 
      else if(navigation.page == "Explore Apps"){
        return ExploreApps();
      }
      else {
        return EAppList();
      }
    }),
    Consumer<Navigation>(builder: (context, navigation, _) {
      if (navigation.page == "Product Detail Book") {
        return ProductDetail();
      } 
      else if (navigation.page == "Explore Books") {
        return ExploreBooks();
      }
      else {
        return EBookList();
      }
    }),
    Consumer<Navigation>(builder: (context, navigation, _) {
      if (navigation.page == "Edit Profile") {
        return EditProfileApp();
      } else {
        return ProfileApp();
      }
    })
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size(MediaQuery.of(context).size.width, 140),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PreferredSize(
                preferredSize: Size(
                    MediaQuery.of(context).size.width, 140),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppBarGerbang(),
                  ],
                ),
              ),
            ]),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10),
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
