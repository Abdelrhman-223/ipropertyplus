import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ipropertyplus/chat/messageField.dart';
import 'package:ipropertyplus/global/myText.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatPersonPage extends StatefulWidget {
  final String userName;

  const ChatPersonPage(this.userName, {super.key});

  @override
  ChatPersonPageState createState() => ChatPersonPageState();
}

bool codeRun = false;
String myName = "";

class ChatPersonPageState extends State<ChatPersonPage> {
  late File stateImg;
  Color mainColor = const Color.fromRGBO(26, 55, 77, 1);
  TextEditingController messageController = TextEditingController();

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: CircleAvatar(
          backgroundColor: mainColor,
        ),
        leadingWidth: 50,
        title: Text(
          widget.userName,
          style: TextStyle(color: mainColor),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        children: [
          MessageField("اهلاً $myName", "receive"),
          MessageField("ما اخبارك", "receive"),
          MessageField("اهلاً ${widget.userName}", "send"),
          MessageField("أنا جيد ما اخبارك انت", "send"),
        ],
      ),
      bottomSheet: BottomSheet(
        onClosing: () {},
        onDragStart: (details) {},
        onDragEnd: (details, {required isClosing}) {},
        builder: (context) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(color: mainColor),
                  borderRadius: BorderRadius.circular(25)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.send_rounded,
                      color: mainColor,
                      size: 30,
                      textDirection: TextDirection.ltr,
                    ),
                    onPressed: () async {},
                  ),
                  Container(
                    width: 240,
                    margin: const EdgeInsets.only(bottom: 13),
                    child: TextField(
                      controller: messageController,
                      cursorColor: mainColor,
                      textAlignVertical: TextAlignVertical.top,
                      maxLines: null,
                      minLines: null,
                      expands: true,
                      style: TextStyle(
                        color: mainColor,
                        fontSize: 20,
                      ),
                      decoration: null,
                    ),
                  ),
                  PopupMenuButton(
                    color: mainColor,
                    icon: Icon(
                      Icons.photo_outlined,
                      color: mainColor,
                      size: 30,
                    ),
                    onSelected: (value) async {
                      if (value == 1) {
                        {
                          ImagePicker camImg = ImagePicker();
                          dynamic getImg =
                              await camImg.getImage(source: ImageSource.camera);
                          setState(() {
                            stateImg = File(getImg.path);
                          });
                        }
                      }
                      if (value == 2) {
                        {
                          ImagePicker camImg = ImagePicker();
                          dynamic getImg = await camImg.getImage(
                              source: ImageSource.gallery);
                          setState(() {
                            stateImg = File(getImg.path);
                          });
                        }
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 2,
                        child: MyText(
                            "المعرض", 20, Colors.white, FontWeight.normal),
                      ),
                      PopupMenuItem(
                        value: 1,
                        child: MyText(
                            "الكاميرا", 20, Colors.white, FontWeight.normal),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
