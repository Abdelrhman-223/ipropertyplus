import 'package:flutter/material.dart';

// ignore: must_be_immutable
class About extends StatelessWidget {
  Color mainColor = Color.fromRGBO(26, 55, 77, 1), secondColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.fromLTRB(40, 80, 40, 20),
          children: [
            Image.asset(
              "assets/images/logo.png",
              height: 140,
              width: 140,
            ),
            Container(
              height: 5,
            ),
            Text("iProperty",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, color: Color(0x33000000))),
            Container(
              height: 50,
            ),
            Text(
              "من نحن",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 35, color: Color(0xff1A374D)),
            ),
            Text(
              "فريق من المطورين المصريين نعمل في برمجة و تطوير و تصميم تطبيقات الهاتف",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: Color(0xff406882)),
            ),
            Container(
              height: 50,
            ),
            Text(
              "مهمتنا",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 35, color: Color(0xff1A374D)),
            ),
            Text(
              "تقديم كافة الخدمات المتعلقة بالعقارات مثل بيع و استئجار العقارات و تسهيل التواصل بين المعلن و العميل",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: Color(0xff406882)),
            ),
            Container(
              height: 50,
            ),
            Text(
              "نطمح إلى",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 35, color: Color(0xff1A374D)),
            ),
            Text(
              "تطوير و تحسين خدماتنا بما يليق بعملائنا الكرام",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: Color(0xff406882)),
            ),
            Container(
              height: 15,
            ),
            Text(
              "خلق سوق تجاري كبير يلبي إحتياجات المواطنين و يساهم في بناء الإقتصاد",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: Color(0xff406882)),
            ),
            Container(
              height: 50,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: mainColor,
        child: Icon(
          Icons.arrow_back,
          color: secondColor,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }
}
