import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class Report extends StatelessWidget {
  TextEditingController userNameController = TextEditingController();
  TextEditingController userPhoneNumberController = TextEditingController();
  TextEditingController reportedNameController = TextEditingController();
  TextEditingController reportedEmailController = TextEditingController();
  TextEditingController reportController = TextEditingController();

  Report({super.key});

  get myFocusNode => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1A374D),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'تقديم شكوى',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        children: [
          TextField(
            controller: userNameController,
            textAlign: TextAlign.right,
            keyboardType: TextInputType.name,
            style: const TextStyle(fontSize: 18, color: Color(0xff1A374D)),
            decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0x33000000)),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xff1A374D)),
              ),
              hintText: "اسمك",
              hintStyle: TextStyle(color: Color(0x33000000)),
              contentPadding: EdgeInsets.only(bottom: 10, top: 10, right: 20),
            ),
            textInputAction: TextInputAction.next,
            onSubmitted: (_) =>
                FocusScope.of(context).requestFocus(myFocusNode),
          ),
          Container(
            height: 10,
          ),
          TextField(
            controller: userPhoneNumberController,
            textAlign: TextAlign.right,
            keyboardType: TextInputType.phone,
            style: const TextStyle(fontSize: 18, color: Color(0xff1A374D)),
            decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0x33000000)),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xff1A374D)),
              ),
              hintText: "رقم هاتفك",
              hintStyle: TextStyle(color: Color(0x33000000)),
              contentPadding: EdgeInsets.only(bottom: 10, top: 10, right: 20),
            ),
            textInputAction: TextInputAction.next,
            onSubmitted: (_) =>
                FocusScope.of(context).requestFocus(myFocusNode),
          ),
          Container(
            height: 10,
          ),
          TextField(
            controller: reportedNameController,
            textAlign: TextAlign.right,
            keyboardType: TextInputType.name,
            style: const TextStyle(fontSize: 18, color: Color(0xff1A374D)),
            decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0x33000000)),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xff1A374D)),
              ),
              hintText: "اسم المشتكي عليه",
              hintStyle: TextStyle(color: Color(0x33000000)),
              contentPadding: EdgeInsets.only(bottom: 10, top: 10, right: 20),
            ),
            textInputAction: TextInputAction.next,
            onSubmitted: (_) =>
                FocusScope.of(context).requestFocus(myFocusNode),
          ),
          Container(
            height: 10,
          ),
          TextField(
            controller: reportedEmailController,
            textAlign: TextAlign.right,
            keyboardType: TextInputType.url,
            style: const TextStyle(fontSize: 18, color: Color(0xff1A374D)),
            decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0x33000000)),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xff1A374D)),
              ),
              hintText: "حسابه الشخصي",
              hintStyle: TextStyle(color: Color(0x33000000)),
              contentPadding: EdgeInsets.only(bottom: 10, top: 10, right: 20),
            ),
            textInputAction: TextInputAction.next,
            onSubmitted: (_) =>
                FocusScope.of(context).requestFocus(myFocusNode),
          ),
          Container(
            height: 10,
          ),
          SizedBox(
            height: 80,
            child: TextField(
              controller: reportController,
              cursorColor: const Color(0xff1A374D),
              maxLines: null,
              minLines: null,
              expands: true,
              textAlign: TextAlign.right,
              keyboardType: TextInputType.multiline,
              style: const TextStyle(fontSize: 18, color: Color(0xff1A374D)),
              decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0x33000000)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff1A374D)),
                ),
                hintText: "شرح وافي لسبب الشكوى",
                hintStyle: TextStyle(color: Color(0x33000000)),
                contentPadding: EdgeInsets.only(bottom: 10, top: 10, right: 20),
              ),
              textInputAction: TextInputAction.newline,
              onSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(myFocusNode),
            ),
          ),
          Container(
            height: 25,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(8),
                backgroundColor: const Color(0xff1A374D),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                elevation: 3,
              ),
              child: const Text('إرسال',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  )),
              onPressed: () async {
                String userName = userNameController.text;
                String userPhoneNumber = userPhoneNumberController.text;
                String reportedName = reportedNameController.text;
                String reportedEmail = reportedEmailController.text;
                String report = reportController.text;

                //SharedPreferences to get the userID
                SharedPreferences sharedPreferencesUserData =
                    await SharedPreferences.getInstance();
                Object? userID = sharedPreferencesUserData.get("userID");
                // firebase report
                WidgetsFlutterBinding.ensureInitialized();
                await Firebase.initializeApp();
                FirebaseFirestore.instance
                    .collection("reports")
                    .add(<String, dynamic>{
                  "userName": userName,
                  "userID": userID,
                  "userPhoneNumber": userPhoneNumber,
                  "reportedName": reportedName,
                  "reportedProfileLink": reportedEmail,
                  "report": report,
                });
              }),
          Container(
            height: 20,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                side: const BorderSide(
                  width: 2.0,
                  color: Colors.red,
                ),
                backgroundColor: Colors.transparent,
                padding: const EdgeInsets.all(8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                elevation: 0,
              ),
              child: const Text('إهمال',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.red,
                  )),
              onPressed: () async {
                userNameController.clear();
                userPhoneNumberController.clear();
                reportedNameController.clear();
                reportedEmailController.clear();
                reportController.clear();
              }),
        ],
      ),
    );
  }
}
