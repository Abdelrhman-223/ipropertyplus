import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ipropertyplus/global/myText.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FollowButton extends StatefulWidget {
  final String userID, userSecondID;

  const FollowButton(this.userID, this.userSecondID, {super.key});

  @override
  FollowButtonState createState() => FollowButtonState();
}

bool codeRun = false, checkId = false, checkFollowing = false;
String buttonText = "متابعة";
String myID = "", mySecondID = "", mainFollowedId = "";

class FollowButtonState extends State<FollowButton> {
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
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("users")
          .doc(myID)
          .collection("userData")
          .doc(mySecondID)
          .collection("followedPeople")
          .snapshots(),
      builder: (context, snapshot) {
        return (snapshot.hasData != true)
            ? const Text("")
            : StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(myID)
                    .collection("userData")
                    .snapshots(),
                builder: (context, snapshot2) {
                  return (snapshot2.hasData != true)
                      ? const Text("")
                      : StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("users")
                              .doc(widget.userID)
                              .collection("userData")
                              .snapshots(),
                          builder: (context, snapshot3) {
                            return (snapshot3.hasData != true)
                                ? const Text("")
                                : TextButton(
                                    onPressed: () async {
                                      setState(() {
                                        for (int i = 0;
                                            i < snapshot.data!.docs.length;
                                            i++) {
                                          if (snapshot.data?.docs[i]
                                                  ["userID"] ==
                                              widget.userID) {
                                            checkId = true;
                                            mainFollowedId =
                                                snapshot.data!.docs[i].id;
                                          }
                                        }
                                      });
                                      setState(() {
                                        if (checkFollowing == false) {
                                          buttonText = "تتابع";
                                          checkFollowing = true;
                                          if (checkId == false) {
                                            FirebaseFirestore.instance
                                                .collection("users")
                                                .doc(myID)
                                                .collection("userData")
                                                .doc(mySecondID)
                                                .collection("followedPeople")
                                                .add(<String, dynamic>{
                                              "userID": widget.userID
                                            });
                                            FirebaseFirestore.instance
                                                .collection("users")
                                                .doc(widget.userID)
                                                .collection("userData")
                                                .doc(widget.userSecondID)
                                                .collection("followingPeople")
                                                .add(<String, dynamic>{
                                              "userID": myID
                                            });
                                            FirebaseFirestore.instance
                                                .collection("users")
                                                .doc(myID)
                                                .collection("userData")
                                                .doc(mySecondID)
                                                .update(<String, dynamic>{
                                              "followedNumber": snapshot2
                                                  .data
                                                  ?.docs[0]["followedPeople"]
                                                  .lingth
                                            });
                                            FirebaseFirestore.instance
                                                .collection("users")
                                                .doc(widget.userID)
                                                .collection("userData")
                                                .doc(widget.userSecondID)
                                                .update(<String, dynamic>{
                                              "followingNumber": snapshot3
                                                  .data
                                                  ?.docs[0]["followingPeople"]
                                                  .lingth
                                            });
                                          }
                                        } else {
                                          buttonText = "متابعة";
                                          checkFollowing = false;
                                          if (checkId == true) {
                                            FirebaseFirestore.instance
                                                .collection("users")
                                                .doc(myID)
                                                .collection("userData")
                                                .doc(mySecondID)
                                                .collection("followedPeople")
                                                .doc(mainFollowedId)
                                                .delete();
                                          }
                                        }
                                      });
                                    },
                                    child: MyText(buttonText, 18, mainColor,
                                        FontWeight.bold),
                                  );
                          },
                        );
                },
              );
      },
    );
  }
}
