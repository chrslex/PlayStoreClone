import 'package:flutter/material.dart';
import 'package:gerbang_app/screens/experimentalAppList.dart';
import 'package:gerbang_app/screens/experimentalBookList.dart';
import 'package:gerbang_app/screens/exploreAllProducts.dart';
import 'package:gerbang_app/screens/ownedAppsAndBooks.dart';
import 'package:gerbang_app/screens/productDetails.dart';
import 'package:gerbang_app/screens/profileScreen.dart';
import 'package:gerbang_app/screens/searchResult.dart';
import 'package:gerbang_app/widget/appBar.dart';
import 'package:gerbang_app/widget/appWidget.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:gerbang_app/screens/editProfile.dart';
import 'package:gerbang_app/screens/loginScreen.dart';
import 'package:gerbang_app/screens/registerScreen.dart';
import 'change_notifier/navigation.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

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
            child: Consumer<Navigation>(builder: (context, navigation, _) {
              if (navigation.page == "Login") {
                return const LoginScreen();
              } else if (navigation.page == "Register") {
                return const RegisterScreen();
              } else {
                return const MyHomePage();
              }
            })));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyHomePage> {
  int _selectedIndex = 0;
  GlobalKey<ScaffoldState> drawerKey = GlobalKey();
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    Consumer<Navigation>(builder: (context, navigation, _) {
      if (navigation.page == "Product Detail App") {
        return const ProductDetail();
      } else if (navigation.page == "Explore Apps") {
        return ExploreApps();
      } else if (navigation.page == "Search Apps") {
        return SearchApps(name:navigation.searchValue!);
      } else if (navigation.page == "Owned Apps/Books") {
        return OwnedAppsOrBooks();
      } else {
        return ExperimentalAppList();
      }
    }),
    Consumer<Navigation>(builder: (context, navigation, _) {
      if (navigation.page == "Product Detail Book") {
        return const ProductDetail();
      } else if (navigation.page == "Explore Books") {
        return ExploreBooks();
      } else if (navigation.page == "Search Books") {
        return SearchBooks(name:navigation.searchValue!);
      } else if(navigation.page == "Owned Apps/Books"){
        return OwnedAppsOrBooks();
      } 
      else {
        return ExperimentalBookList();
      }
    }),
    Consumer<Navigation>(builder: (context, navigation, _) {
      if (navigation.page == "Edit Profile") {
        return EditProfileApp();
      } else if (navigation.page == "Search Apps") {
        return SearchApps(name: navigation.searchValue!);
      } else if (navigation.page == "Search Books") {
        return SearchBooks(name:navigation.searchValue!);
      } else if (navigation.page == "Owned Apps/Books") {
        return OwnedAppsOrBooks();
      } else {
        return const ProfileScreen();
      }
    })
  ];

  void _appBarStatus(bool show) {}

  @override
  Widget build(BuildContext context) {
    return Consumer<Navigation>(
        builder: (context, navigation, _) => Scaffold(
              key: drawerKey,
              appBar: navigation.showAppBar
                  ? mainAppBar(context)
                  : null,
              body: Container(
                margin: const EdgeInsets.only(top: 10),
                child: _widgetOptions.elementAt(_selectedIndex),
              ),
              drawer: DrawerGerbang(),
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
                onTap: (int index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                  navigation.selectedIndex = index;
                },
              ),
            ));
  }

  PreferredSize mainAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize:
          Size(MediaQuery.of(context).size.width, 140),
      child:
          Column(mainAxisSize: MainAxisSize.min, children: [
        PreferredSize(
          preferredSize:
              Size(MediaQuery.of(context).size.width, 140),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppBarGerbang(),
            ],
          ),
        ),
      ]),
    );
  }
}

class DrawerGerbang extends StatelessWidget {
  const DrawerGerbang({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.only(top: 32),
          child: Column(
            children: [
              8.height,
              Row(
                children: [
                  Image.asset(
                    "assets/launch_image.png",
                    width: 30,
                    height: 30,
                  ).paddingOnly(left: 8),
                  Text(
                    'App',
                    style: boldTextStyle(),
                  )
                ],
              ),
              4.height,
              Divider(thickness: 1),
              Consumer<Navigation>(
                builder: (context, navigation, _) =>
                    ListTile(
                  visualDensity:
                      VisualDensity(vertical: -4),
                  onTap: () {
                    finish(context);
                    navigation.setShowAppBar = false;
                    navigation.setPage = "Owned Apps/Books";
                    // Owned Books and Apps
                  },
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                          MaterialCommunityIcons.apps_box,
                          size: 20,
                          color: Colors.black54)
                      .paddingOnly(left: 8),
                  title: Text("Owned Apps and Books"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
