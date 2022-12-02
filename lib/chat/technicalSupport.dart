import 'package:flutter/material.dart';
import 'package:ipropertyplus/chat/messageField.dart';

class TechnicalSupport extends StatefulWidget {
  const TechnicalSupport({super.key});

  @override
  TechnicalSupportState createState() => TechnicalSupportState();
}

class TechnicalSupportState extends State<TechnicalSupport> {
  Color mainColor = const Color.fromRGBO(26, 55, 77, 1);
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Image.asset("assets/images/logo.png"),
        ),
        leadingWidth: 50,
        title: Text(
          "الدعم الفني",
          style: TextStyle(color: mainColor),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.arrow_forward,
              color: mainColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        children: [
          MessageField("لدي مشكلة", "receive"),
          MessageField("معك الدعم الفني من فضلك ارسل مشكلتك", "send"),
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
                  borderRadius: BorderRadius.circular(50)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.send_rounded,
                      color: mainColor,
                      size: 30,
                      textDirection: TextDirection.ltr,
                    ),
                    onPressed: () async {
                      setState(() {
                        messageController.clear();
                      });
                    },
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
                  IconButton(
                    icon: Icon(
                      Icons.photo_outlined,
                      color: mainColor,
                      size: 30,
                    ),
                    onPressed: () {},
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
