import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ipropertyplus/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

// ignore: must_be_immutable
class Signup extends StatelessWidget {
  String userID = "", userSecondID = "";
  TextEditingController userNameController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();
  TextEditingController userPhoneNumberController = TextEditingController();

  Signup({super.key});

  get myFocusNode => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        elevation: 0,
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
        children: [
          Container(
            height: 10,
          ),
          const Text("Sign up",
              style: TextStyle(fontSize: 28, color: Color(0xff406882)),
              textAlign: TextAlign.center),
          Container(
            height: 40,
          ),
          TextField(
            controller: userNameController,
            keyboardType: TextInputType.name,
            textAlign: TextAlign.left,
            style: const TextStyle(fontSize: 18, color: Color(0xff1A374D)),
            decoration: const InputDecoration(
              hintText: "Username",
              hintStyle: TextStyle(color: Color(0x33000000)),
              fillColor: Color(0xffE8EBED),
              filled: true,
              contentPadding: EdgeInsets.only(bottom: 10, top: 10, left: 20),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12),
                  borderRadius: BorderRadius.all(Radius.circular(100))),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12),
                  borderRadius: BorderRadius.all(Radius.circular(100))),
            ),
            textInputAction: TextInputAction.next,
            onSubmitted: (_) =>
                FocusScope.of(context).requestFocus(myFocusNode),
          ),
          Container(
            height: 10,
          ),
          TextField(
            controller: userEmailController,
            keyboardType: TextInputType.emailAddress,
            textAlign: TextAlign.left,
            style: const TextStyle(fontSize: 18, color: Color(0xff1A374D)),
            decoration: const InputDecoration(
              hintText: "Email",
              hintStyle: TextStyle(color: Color(0x33000000)),
              fillColor: Color(0xffE8EBED),
              filled: true,
              contentPadding: EdgeInsets.only(bottom: 10, top: 10, left: 20),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12),
                  borderRadius: BorderRadius.all(Radius.circular(100))),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12),
                  borderRadius: BorderRadius.all(Radius.circular(100))),
            ),
            textInputAction: TextInputAction.next,
            onSubmitted: (_) =>
                FocusScope.of(context).requestFocus(myFocusNode),
          ),
          Container(
            height: 10,
          ),
          TextField(
            controller: userPasswordController,
            textAlign: TextAlign.left,
            textDirection: TextDirection.ltr,
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            style: const TextStyle(fontSize: 18, color: Color(0xff1A374D)),
            decoration: const InputDecoration(
              hintText: "Password",
              hintStyle: TextStyle(color: Color(0x33000000)),
              fillColor: Color(0xffE8EBED),
              filled: true,
              contentPadding: EdgeInsets.only(bottom: 10, top: 10, left: 20),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12),
                  borderRadius: BorderRadius.all(Radius.circular(100))),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12),
                  borderRadius: BorderRadius.all(Radius.circular(100))),
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
            keyboardType: TextInputType.phone,
            textAlign: TextAlign.left,
            style: const TextStyle(fontSize: 18, color: Color(0xff1A374D)),
            decoration: const InputDecoration(
              hintText: "Phone",
              hintStyle: TextStyle(color: Color(0x33000000)),
              fillColor: Color(0xffE8EBED),
              filled: true,
              contentPadding: EdgeInsets.only(bottom: 10, top: 10, left: 20),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12),
                  borderRadius: BorderRadius.all(Radius.circular(100))),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12),
                  borderRadius: BorderRadius.all(Radius.circular(100))),
            ),
            textInputAction: TextInputAction.done,
            onSubmitted: (_) =>
                FocusScope.of(context).requestFocus(myFocusNode),
          ),
          Container(
            height: 50,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(8),
                backgroundColor: const Color(0xff1A374D),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                elevation: 3,
              ),
              child: const Text('Register',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  )),
              onPressed: () async {
                String userName = userNameController.text;
                String userEmail = userEmailController.text;
                String userPassword = userPasswordController.text;
                String userPhoneNumber = userPhoneNumberController.text;
                // firebase signup
                SharedPreferences sharedPreferencesUserData =
                    await SharedPreferences.getInstance();
                WidgetsFlutterBinding.ensureInitialized();
                await Firebase.initializeApp();
                userID =
                    FirebaseFirestore.instance.collection("users").doc().id;
                userSecondID = FirebaseFirestore.instance
                    .collection("users")
                    .doc(userID)
                    .collection("userData")
                    .doc()
                    .id;
                FirebaseFirestore.instance
                    .collection("users")
                    .doc(userID)
                    .set(<String, dynamic>{
                  "userID": userID,
                  "userEmail": userEmail,
                  "userPassword": userPassword,
                  "userName": userName,
                  "userPhoneNumber": userPhoneNumber,
                  "userSecondID": userSecondID,
                });
                FirebaseFirestore.instance
                    .collection("users")
                    .doc(userID)
                    .collection("userData")
                    .doc(userSecondID)
                    .set(<String, dynamic>{
                  "userSecondID": userSecondID,
                });
                FirebaseFirestore.instance
                    .collection("users")
                    .doc(userID)
                    .collection("userData")
                    .doc(userSecondID)
                    .update(<String, dynamic>{
                  "userName": userName,
                  "userPassword": userPassword,
                  "userEmail": userEmail,
                  "userPhoneNumber": userPhoneNumber,
                  "userAddress": "",
                  "userCity": "",
                  "followedNumber": 0,
                  "followingNumber": 0,
                  "checkPosted": "false",
                });
                FirebaseFirestore.instance
                    .collection("users")
                    .doc(userID)
                    .collection("userData")
                    .doc(userSecondID)
                    .collection("favoritePosts")
                    .add(<String, dynamic>{
                  "postID": "initial",
                });
                FirebaseFirestore.instance
                    .collection("users")
                    .doc(userID)
                    .collection("userData")
                    .doc(userSecondID)
                    .collection("followedPeople")
                    .add(<String, dynamic>{
                  "postID": "initial",
                });
                FirebaseFirestore.instance
                    .collection("users")
                    .doc(userID)
                    .collection("userData")
                    .doc(userSecondID)
                    .collection("followingPeople")
                    .add(<String, dynamic>{
                  "postID": "initial",
                });
                sharedPreferencesUserData.setString("userID", userID);
                sharedPreferencesUserData.setString(
                    "userSecondID", userSecondID);
                sharedPreferencesUserData.setString("userName", userName);
                sharedPreferencesUserData.setString("userEmail", userEmail);
                sharedPreferencesUserData.setString(
                    "userPassword", userPassword);
                sharedPreferencesUserData.setString(
                    "userPhoneNumber", userPhoneNumber);
                sharedPreferencesUserData.setBool("signedUp", true);
                userNameController.clear();
                userEmailController.clear();
                userPasswordController.clear();
                userPhoneNumberController.clear();
                // ignore: use_build_context_synchronously
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyHomePage()));
              }),
          Container(
            height: 70,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Already have account?\t\t",
                  style: TextStyle(fontSize: 15, color: Color(0x33000000))),
              InkWell(
                child: const Text(
                  "Sign in",
                  style: TextStyle(fontSize: 15, color: Color(0xff1A374D)),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
