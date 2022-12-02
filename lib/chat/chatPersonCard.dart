import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ipropertyplus/chat/chatPersonPage.dart';
import 'package:ipropertyplus/global/myText.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatPersonCard extends StatefulWidget {
  final String userID;

  const ChatPersonCard(this.userID, {super.key});

  @override
  ChatPersonCardState createState() => ChatPersonCardState();
}

bool codeRun = false;
String myID = "", mySecondID = "", myChatID = "";

class ChatPersonCardState extends State<ChatPersonCard> {
  Color mainColor = const Color.fromRGBO(26, 55, 77, 1),
      fontsSupColor = const Color.fromRGBO(91, 92, 93, 1);

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
            .doc(widget.userID)
            .collection("userData")
            .snapshots(),
        builder: (context, snapshot1) {
          return (snapshot1.hasData != true)
              ? Align(
                  alignment: Alignment.center,
                  child:
                      MyText("No Connection", 22, mainColor, FontWeight.bold),
                )
              : Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        myChatID = FirebaseFirestore.instance
                            .collection("users")
                            .doc(myID)
                            .collection("chat")
                            .doc()
                            .id;
                        FirebaseFirestore.instance
                            .collection("users")
                            .doc(myID)
                            .collection("chat")
                            .doc(myChatID)
                            .set(<String, dynamic>{
                          "userID": widget.userID,
                        });
                        FirebaseFirestore.instance
                            .collection("users")
                            .doc(myID)
                            .collection("chat")
                            .doc(myChatID)
                            .collection("messages")
                            .add(<String, dynamic>{
                          "message": "Initial Message",
                          "messageType": "send",
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatPersonPage(
                                  snapshot1.data?.docs[0]["userName"]),
                            ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: mainColor,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot1.data?.docs[0]["userName"],
                                      style: TextStyle(
                                          color: mainColor, fontSize: 22),
                                    ),
                                    SizedBox(
                                      width: 190,
                                      child: Text(
                                        "أخر رسالة تم عرضها في المحادثة اضغط لعرضها",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: fontsSupColor, fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Text("11:15 ص"),
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                  ],
                );
        });
  }
}
