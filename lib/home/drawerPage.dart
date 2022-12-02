import 'package:flutter/material.dart';
import 'package:ipropertyplus/global/myText.dart';
import 'package:ipropertyplus/profile/profile.dart';
import 'package:ipropertyplus/splashScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'drawerListTile.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  DrawerPageState createState() => DrawerPageState();
}

bool codeRun = false;
String myName = " ";

class DrawerPageState extends State<DrawerPage> {
  double stackHeight = 100;
  Color mainColor = const Color.fromRGBO(26, 55, 77, 1),
      secondColor = Colors.white,
      dividerColor = const Color.fromRGBO(224, 224, 229, 1);

  getSharedPreferencesUserData() async {
    SharedPreferences sharedPreferencesUserData =
        await SharedPreferences.getInstance();
    setState(() {
      myName = sharedPreferencesUserData.getString("userName")!;
      codeRun = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (codeRun == false) getSharedPreferencesUserData();
    return Drawer(
      child: ListView(
        children: [
          SizedBox(
            height: stackHeight * (5 / 3),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: stackHeight,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.elliptical(
                        stackHeight * 2,
                        stackHeight * (2 / 3),
                      ),
                      bottomRight: Radius.elliptical(
                          stackHeight * 2, stackHeight * (2 / 3)),
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 2,
                        blurRadius: 1,
                        offset: Offset(3, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.clear,
                          color: secondColor,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.logout,
                          color: secondColor,
                        ),
                        onPressed: () async {
                          SharedPreferences sharedPreferencesUserData =
                              await SharedPreferences.getInstance();
                          sharedPreferencesUserData.remove("signedUp");
                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SplashScreen()));
                        },
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: stackHeight / 2,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProfilePage()));
                    },
                    child: const CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfilePage()));
              },
              child: MyText(myName, 22, mainColor, FontWeight.bold),
            ),
          ),
          Divider(
            color: dividerColor,
            height: 15,
            thickness: 1,
          ),
          DrawerListTile("المفضلة", Icons.favorite_rounded),
          Divider(
            color: dividerColor,
            height: 5,
            thickness: 1,
          ),
          DrawerListTile("السجل", Icons.history_rounded),
          Divider(
            color: dividerColor,
            height: 5,
            thickness: 1,
          ),
          DrawerListTile("الإعدادات", Icons.settings),
          Divider(
            color: dividerColor,
            height: 5,
            thickness: 1,
          ),
          DrawerListTile("الدعم الفني", Icons.support_agent_rounded),
          Divider(
            color: dividerColor,
            height: 5,
            thickness: 1,
          ),
          DrawerListTile("تقديم شكوى", Icons.report_problem_rounded),
          Divider(
            color: dividerColor,
            height: 5,
            thickness: 1,
          ),
          DrawerListTile("معلومات عنا", Icons.info_rounded),
        ],
      ),
    );
  }
}
