import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ipropertyplus/home/drawerPage.dart';
import 'package:ipropertyplus/posts/postField.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FollowingPage extends StatefulWidget {
  const FollowingPage({super.key});

  @override
  FollowingPageState createState() => FollowingPageState();
}

bool codeRun = false;
String myID = "", mySecondID = "";

class FollowingPageState extends State<FollowingPage> {
  Color mainColor = const Color.fromRGBO(26, 55, 77, 1),
      supTextColor = const Color.fromRGBO(26, 55, 77, .5),
      fieldBackgroundColor = const Color.fromRGBO(224, 224, 229, 1),
      secondColor = Colors.white;

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
          "إعلانات أشخاص تتابعهم",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: mainColor,
        centerTitle: true,
      ),
      drawer: const DrawerPage(),
      body: SafeArea(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("peoplePosted")
                .snapshots(),
            builder: (context, snapshot1) {
              return (snapshot1.hasData != true)
                  ? const Text("")
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: snapshot1.data?.docs.length,
                      itemBuilder: (context, index1) {
                        return StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("users")
                                .doc(snapshot1.data?.docs[index1]["userID"])
                                .collection("posts")
                                .snapshots(),
                            builder: (context, snapshot2) {
                              return (snapshot2.hasData != true)
                                  ? const Text("")
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      physics: const ClampingScrollPhysics(),
                                      itemCount: snapshot2.data?.docs.length,
                                      itemBuilder: (context, index2) {
                                        return Post(
                                            false,
                                            snapshot1.data?.docs[index1]
                                                ["userID"],
                                            snapshot2.data?.docs[index2]
                                                ["userPostID"]);
                                      },
                                    );
                            });
                      },
                    );
            }),
      ),
    );
  }
}
