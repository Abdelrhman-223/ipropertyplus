import 'package:flutter/material.dart';

class Log extends StatelessWidget {
  const Log({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1A374D),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'السجل',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      body: ListView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(20),
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              height: 375,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(0.0, 2.0),
                  ),
                ],
                border: Border.all(
                  color: Colors.transparent,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(15)),
              ),
              child: Column(
                children: [
                  Container(
                    width: 350,
                    height: 200,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.contain,
                        image: AssetImage("assets/images/logo.png"),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text("رقم العملية:",
                          style: TextStyle(
                              fontSize: 18, color: Color(0xff1A374D))),
                      Container(
                        width: 110,
                      ),
                      const Text("10264",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 18, color: Color(0x33000000))),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text("نوع العملية:",
                          style: TextStyle(
                              fontSize: 18, color: Color(0xff1A374D))),
                      Container(
                        width: 110,
                      ),
                      const Text("شراء",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 18, color: Color(0x33000000))),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text("تاريخ العملية:",
                          style: TextStyle(
                              fontSize: 18, color: Color(0xff1A374D))),
                      Container(
                        width: 110,
                      ),
                      const Text("1/1/2021",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 18, color: Color(0x33000000))),
                    ],
                  ),
                ],
              ),
            ),
          ]),
    );
  }
}
