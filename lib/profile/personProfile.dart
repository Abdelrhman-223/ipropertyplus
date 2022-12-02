import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ipropertyplus/chat/chatPersonPage.dart';
import 'package:ipropertyplus/following/followButton.dart';
import 'package:ipropertyplus/global/myText.dart';
import 'package:ipropertyplus/posts/postField.dart';

// ignore: must_be_immutable
class PersonProfilePage extends StatefulWidget {
  String userID, userSecondID;

  PersonProfilePage(this.userID, this.userSecondID, {super.key});

  @override
  PersonProfilePageState createState() => PersonProfilePageState();
}

class PersonProfilePageState extends State<PersonProfilePage> {
  double stackHeight = 140;
  Color mainColor = const Color.fromRGBO(26, 55, 77, 1),
      supTextColor = const Color.fromRGBO(26, 55, 77, .1),
      fieldBackgroundColor = const Color.fromRGBO(224, 224, 229, 1),
      secondColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("users")
                .doc(widget.userID)
                .collection("userData")
                .snapshots(),
            builder: (context, snapshot1) {
              if ((snapshot1.hasData != true)) {
                return Align(
                  alignment: Alignment.center,
                  child:
                      MyText("No Connection", 22, mainColor, FontWeight.bold),
                );
              } else {
                return ListView(
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
                                MyText(
                                    "يتابع", 18, mainColor, FontWeight.normal),
                                MyText(
                                    "${snapshot1.data?.docs[0]["followedNumber"]}",
                                    18,
                                    mainColor,
                                    FontWeight.normal),
                              ],
                            ),
                          ),
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
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.chat,
                              color: mainColor,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChatPersonPage(
                                          snapshot1.data?.docs[0]["userName"])),
                                );
                              },
                              child: MyText(
                                  "تواصل", 18, mainColor, FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.person_add_rounded,
                              color: mainColor,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            FollowButton(widget.userID, widget.userSecondID)
                          ],
                        ),
                      ],
                    ),
                    const Divider(
                      height: 20,
                      thickness: 1,
                    ),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("users")
                            .doc(widget.userID)
                            .collection("posts")
                            .snapshots(),
                        builder: (context, snapshot2) {
                          return (snapshot2.hasData != true)
                              ? Align(
                                  alignment: Alignment.center,
                                  child: MyText("No Connection", 22, mainColor,
                                      FontWeight.bold),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const ClampingScrollPhysics(),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  itemCount: snapshot2.data?.docs.length,
                                  itemBuilder: (context, index) {
                                    return Post(
                                        false,
                                        widget.userID,
                                        snapshot2.data?.docs[index]
                                            ["userPostID"]);
                                  },
                                );
                        }),
                  ],
                );
              }
            }),
      ),
    );
  }
}
