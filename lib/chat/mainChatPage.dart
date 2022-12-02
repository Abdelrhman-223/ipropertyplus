import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ipropertyplus/global/myText.dart';
import 'package:ipropertyplus/home/drawerPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'chatPersonCard.dart';

class MainChatPage extends StatefulWidget {
  const MainChatPage({super.key});

  @override
  MainChatPageState createState() => MainChatPageState();
}

bool codeRun = false;
String myID = "", mySecondID = "";

class MainChatPageState extends State<MainChatPage> {
  Color mainColor = const Color.fromRGBO(26, 55, 77, 1);

  getSharedPreferencesUserData() async {
    SharedPreferences sharedPreferencesUserData =
        await SharedPreferences.getInstance();
    setState(() {
      myID = sharedPreferencesUserData.getString("userID")!;
      mySecondID = sharedPreferencesUserData.getString("userSecondID")!;
      codeRun = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (codeRun == false) getSharedPreferencesUserData();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "المحادثات",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: mainColor,
        centerTitle: true,
      ),
      drawer: const DrawerPage(),
      body: SafeArea(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("users").snapshots(),
            builder: (context, snapshot1) {
              return (snapshot1.hasData != true)
                  ? Align(
                      alignment: Alignment.center,
                      child: MyText(
                          "No Connection", 22, mainColor, FontWeight.bold),
                    )
                  : ListView.builder(
                      itemCount: snapshot1.data?.docs.length,
                      itemBuilder: (context, index) {
                        return (snapshot1.data?.docs[index]["userID"] ==
                                "initial")
                            ? const Text(" ")
                            : ChatPersonCard(
                                snapshot1.data?.docs[index]["userID"]);
                      });
            }),
      ),
    );
  }
}
