import 'package:flutter/material.dart';
import 'package:ipropertyplus/global/myText.dart';
import 'package:ipropertyplus/global/switchField.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  SettingsState createState() => SettingsState();
}

class SettingsState extends State<Settings> {
  bool darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1A374D),
        elevation: 0,
        centerTitle: true,
        title: const Text('الإعدادات',
            style: TextStyle(fontSize: 20, color: Colors.white)),
      ),
      body: ListView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(20),
          children: [
            MyText("خاصية الوضع المظلم غير مفعلة حالياً :)", 18,
                const Color(0xff1A374D), FontWeight.normal),
            SwitchField("وضع الليل:", false),
            const Divider(),
            Row(children: const [
              Text("تسجيل خروج",
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 18, color: Color(0xff1A374D))),
              Icon(Icons.logout, color: Color(0xff1A374D)),
            ]),
          ]),
    );
  }
}
