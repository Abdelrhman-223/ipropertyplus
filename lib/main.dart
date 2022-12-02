import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ipropertyplus/chat/mainChatPage.dart';
import 'package:ipropertyplus/following/following.dart';
import 'package:ipropertyplus/home/homePage.dart';
import 'package:ipropertyplus/posts/addPost.dart';
import 'package:ipropertyplus/profile/profile.dart';
import 'package:ipropertyplus/splashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

Color mainColor = const Color.fromRGBO(26, 55, 77, 1);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'iProperty',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('ar', 'AE'), // English, no country code
      ],
      home: SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  int bottomNavigationBarItemIndex = 0;
  List<Widget> pages = const [
    HomePage(),
    FollowingPage(),
    AddPost(),
    MainChatPage(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: bottomNavigationBarItemIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomNavigationBarItemIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        onTap: (value) async {
          setState(() {
            bottomNavigationBarItemIndex = value;
          });
        },
        iconSize: 30,
        selectedIconTheme: IconThemeData(color: mainColor, size: 40),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group_rounded),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message_rounded),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: "",
          ),
        ],
      ),
    );
  }
}
