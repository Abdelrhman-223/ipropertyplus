import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ipropertyplus/following/following.dart';
import 'package:ipropertyplus/global/myText.dart';
import 'package:ipropertyplus/posts/postField.dart';
import 'package:ipropertyplus/profile/editProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

bool codeRun = false;
String myID = "", mySecondID = "";

class ProfilePageState extends State<ProfilePage> {
  double stackHeight = 140;
  Color mainColor = const Color.fromRGBO(26, 55, 77, 1),
      supTextColor = const Color.fromRGBO(26, 55, 77, .1),
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
      body: SafeArea(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("users")
                .doc(myID).collection("userData")
                .snapshots(),
            builder: (context, snapshot1) {
              return (snapshot1.hasData != true ||
                      snapshot1.data?.docs[0]["checkPosted"] == "true")
                  ? const Text("")
                  : ListView(
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
                              ),
                              Positioned(
                                top: stackHeight / 2,
                                child: const CircleAvatar(
                                  radius: 75,
                                  backgroundColor: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: MyText(snapshot1.data?.docs[0]["userName"], 22,
                              mainColor, FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              child: Container(
                                height: 100,
                                width: 150,
                                margin: const EdgeInsets.only(bottom: 20),
                                decoration: BoxDecoration(
                                  color: supTextColor,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    MyText("تتابع", 18, mainColor,
                                        FontWeight.normal),
                                    MyText(
                                        "${snapshot1.data?.docs[0]["followedNumber"]}",
                                        18,
                                        mainColor,
                                        FontWeight.normal),
                                  ],
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FollowingPage(),
                                    ));
                              },
                            ),
                            GestureDetector(
                              child: Container(
                                height: 100,
                                width: 150,
                                margin: const EdgeInsets.only(bottom: 20),
                                decoration: BoxDecoration(
                                  color: supTextColor,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    MyText("متابعين", 18, mainColor,
                                        FontWeight.normal),
                                    MyText(
                                        "${snapshot1.data?.docs[0]["followingNumber"]}",
                                        18,
                                        mainColor,
                                        FontWeight.normal),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const EditProfilePage(),
                                ));
                          },
                          child: MyText(
                              "تعديل الحساب", 18, mainColor, FontWeight.normal),
                        ),
                        const Divider(
                          height: 10,
                          thickness: 1,
                        ),
                        StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("users")
                                .doc(myID)
                                .collection("posts")
                                .snapshots(),
                            builder: (context, snapshot2) {
                              return (snapshot2.hasData != true)
                                  ? const Text("")
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      physics: const ClampingScrollPhysics(),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      itemCount: snapshot2.data?.docs.length,
                                      itemBuilder: (context, index) {
                                        return Post(
                                            false,
                                            myID,
                                            snapshot2.data?.docs[index]
                                                ["userPostID"]);
                                      },
                                    );
                            }),
                      ],
                    );
            }),
      ),
    );
  }
}
