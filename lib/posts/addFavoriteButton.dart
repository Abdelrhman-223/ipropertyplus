import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class AddFavoriteButton extends StatefulWidget {
  bool cameFromFavorite;
  String userID, userPostID;

  AddFavoriteButton(this.cameFromFavorite, this.userID, this.userPostID,
      {super.key});

  @override
  AddFavoriteButtonState createState() => AddFavoriteButtonState();
}

bool checkHeartIcon = false,
    checkId = false,
    codeRun = false,
    checkIconRun = false;
String myID = "", mySecondID = "", postMainID = "";

class AddFavoriteButtonState extends State<AddFavoriteButton> {
  Icon heartIcon = const Icon(Icons.favorite_border_rounded);
  Color mainColor = const Color.fromRGBO(26, 55, 77, 1),
      supTextColor = Colors.grey,
      fieldBackgroundColor = const Color.fromRGBO(224, 224, 229, 1);

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
    if (checkIconRun == false && widget.cameFromFavorite == true) {
      setState(() {
        checkHeartIcon = true;
        checkIconRun = true;
      });
    }
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("users")
          .doc(myID)
          .collection("userData")
          .doc(mySecondID)
          .collection("favoritePosts")
          .snapshots(),
      builder: (context, snapshot) {
        return (snapshot.hasData != true)
            ? const Text("")
            : IconButton(
                icon: heartIcon,
                color: mainColor,
                iconSize: 30,
                onPressed: () async {
                  setState(() {
                    for (int i = 0; i < snapshot.data!.docs.length; i++) {
                      if (snapshot.data!.docs[i]["postID"] ==
                          widget.userPostID) {
                        checkId = true;
                        postMainID = snapshot.data!.docs[i].id;
                      }
                    }
                  });
                  if (checkHeartIcon == false) {
                    heartIcon = const Icon(Icons.favorite_rounded);
                    checkHeartIcon = true;
                    if (checkId == false) {
                      FirebaseFirestore.instance
                          .collection("users")
                          .doc(myID)
                          .collection("userData")
                          .doc(mySecondID)
                          .collection("favoritePosts")
                          .add(<String, dynamic>{
                        "postID": widget.userPostID,
                        "userID": widget.userID,
                      });
                    }
                    checkId = true;
                  } else {
                    heartIcon = const Icon(Icons.favorite_border_rounded);
                    checkHeartIcon = false;
                    if (checkId == true) {
                      FirebaseFirestore.instance
                          .collection("users")
                          .doc(myID)
                          .collection("userData")
                          .doc(mySecondID)
                          .collection("favoritePosts")
                          .doc(postMainID)
                          .delete();
                    }
                    checkId = false;
                  }
                },
              );
      },
    );
  }
}
