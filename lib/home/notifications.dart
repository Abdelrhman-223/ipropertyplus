import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'الإشعارات',
          style: TextStyle(fontSize: 20, color: Color(0xff1A374D)),
        ),
        iconTheme: IconThemeData(
          color: Color(0xff1A374D),
        ),
      ),
      body: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
          children: [
            Column(
              children: [
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      margin: EdgeInsets.only(left: 20),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      ),
                    ),
                    Text("اسم المستخدم",
                        style:
                            TextStyle(fontSize: 18, color: Color(0xff1A374D))),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("علق على إعلانك السابق",
                        style:
                            TextStyle(fontSize: 16, color: Color(0xff50534B))),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("منذ دقيقة",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff50534B),
                        )),
                  ],
                ),
                Divider(),
              ],
            ),
          ]),
    );
  }
}
