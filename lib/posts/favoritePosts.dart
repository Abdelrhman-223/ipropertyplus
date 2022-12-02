import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ipropertyplus/global/myText.dart';
import 'package:ipropertyplus/posts/postField.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritePosts extends StatefulWidget {
  const FavoritePosts({super.key});

  @override
  FavoritePostsState createState() => FavoritePostsState();
}

bool codeRun = false;
String myID = "", mySecondID = "";

class FavoritePostsState extends State<FavoritePosts> {
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
    if (codeRun == false) {
      getSharedPreferencesUserData();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'المفضلات',
          style: TextStyle(fontSize: 20, color: secondColor),
        ),
      ),
      body: SafeArea(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("users")
                .doc(myID)
                .collection("userData")
                .doc(mySecondID)
                .collection("favoritePosts")
                .snapshots(),
            builder: (context, snapshot1) {
              return (snapshot1.hasData != true)
                  ? Align(
                      alignment: Alignment.center,
                      child: MyText(
                          "No Favorites", 22, mainColor, FontWeight.bold),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: snapshot1.data?.docs.length,
                      itemBuilder: (context, index) {
                        return (snapshot1.data?.docs[index]["postID"] ==
                                "initial")
                            ? const Text("")
                            : Post(true, snapshot1.data?.docs[index]["userID"],
                                snapshot1.data?.docs[index]["postID"]);
                      },
                    );
            }),
      ),
    );
  }
}
