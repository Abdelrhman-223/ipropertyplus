import 'package:flutter/material.dart';

class Comments extends StatefulWidget {
  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  get myFocusNode => null;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'التعليقات',
          style: TextStyle(fontSize: 20, color: Color(0xff1A374D)),
        ),
        iconTheme: IconThemeData(
          color: Color(0xff1A374D),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
      ),
      body: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
          children: [
            TextField(
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 18, color: Color(0xff1A374D)),
              decoration: InputDecoration(
                hintText: "إضافة تعليق",
                fillColor: Color(0xffE8EBED),
                filled: true,
                hintStyle: TextStyle(color: Color(0x33000000)),
                contentPadding: EdgeInsets.only(bottom: 8, top: 8, right: 8),
                prefixIcon: IconButton(
                  icon: Icon(Icons.done_outline_rounded),
                  color: Color(0xff1A374D),
                  onPressed: () {},
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black12),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black12),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
              ),
              textInputAction: TextInputAction.done,
              onSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(myFocusNode),
            ),
            Divider(),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("اسم المستخدم",
                        style:
                            TextStyle(fontSize: 18, color: Color(0xff1A374D))),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/images/user.png")),
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.transparent,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("التعليق",
                        style:
                            TextStyle(fontSize: 16, color: Color(0xff50534B))),
                  ],
                ),
                Divider(
                  color: Colors.transparent,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.reply),
                      color: Color(0xff50534B),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.thumb_down_outlined),
                      color: Color(0xff50534B),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.thumb_up_outlined),
                      color: Color(0xff50534B),
                      onPressed: () {},
                    ),
                  ],
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      elevation: 0,
                    ),
                    child: Text('رؤية جميع الردود',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff1A374D),
                        )),
                    onPressed: () async {}),
              ],
            ),
          ]),
    );
  }
}
