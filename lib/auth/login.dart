import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ipropertyplus/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  LoginState createState() => LoginState();
}

bool checkEmail = false;

class LoginState extends State<Login> {
  String notFoundText = "", userEmail = "", userPassword = "";
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();

  get myFocusNode => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.fromLTRB(40, 80, 40, 20),
        children: [
          Image.asset(
            "assets/images/logo.png",
            height: 140,
            width: 140,
          ),
          Container(
            height: 10,
          ),
          const Text("Sign in",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, color: Color(0x33000000))),
          Container(
            height: 10,
          ),
          Text(notFoundText,
              textAlign: TextAlign.center,
              textDirection: TextDirection.ltr,
              style: const TextStyle(fontSize: 16, color: Colors.red)),
          Container(
            height: 25,
          ),
          TextField(
            controller: userEmailController,
            textAlign: TextAlign.left,
            keyboardType: TextInputType.emailAddress,
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
            height: 15,
          ),
          TextField(
            controller: userPasswordController,
            textAlign: TextAlign.left,
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            textDirection: TextDirection.ltr,
            style: const TextStyle(fontSize: 18, color: Color(0xff1A374D)),
            decoration: const InputDecoration(
              hintText: "Password",
              fillColor: Color(0xffE8EBED),
              filled: true,
              hintStyle: TextStyle(color: Color(0x33000000)),
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
            height: 35,
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection("users").snapshots(),
            builder: (context, snapshot1) {
              return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(8),
                    backgroundColor: const Color(0xff1A374D),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    elevation: 3,
                  ),
                  child: const Text('Login',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      )),
                  onPressed: () async {
                    userEmail = userEmailController.text;
                    userPassword = userPasswordController.text;
                    // firebase login
                    SharedPreferences sharedPreferencesUserData =
                        await SharedPreferences.getInstance();
                    for (int i = 0; i < snapshot1.data!.docs.length; i++) {
                      if (userEmail == snapshot1.data!.docs[i]["userEmail"] &&
                          userPassword ==
                              snapshot1.data?.docs[i]["userPassword"]) {
                        sharedPreferencesUserData.setString(
                            "userEmail", userEmail);
                        sharedPreferencesUserData.setString(
                            "userPassword", userPassword);
                        sharedPreferencesUserData.setString(
                            "userID", snapshot1.data?.docs[i]["userID"]);
                        sharedPreferencesUserData.setString(
                            "userName", snapshot1.data?.docs[i]["userName"]);
                        sharedPreferencesUserData.setString("userSecondID",
                            snapshot1.data?.docs[i]["userSecondID"]);
                        sharedPreferencesUserData.setString("userPhoneNumber",
                            snapshot1.data?.docs[i]["userPhoneNumber"]);
                        sharedPreferencesUserData.setBool("signedUp", true);
                        setState(() {
                          checkEmail = true;
                        });
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyHomePage()));
                      }
                      if (checkEmail == false &&
                          i == snapshot1.data!.docs.length - 1) {
                        setState(() {
                          notFoundText = "The account or password is wrong.";
                        });
                      }
                    }
                  });
            },
          ),
          Container(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("New user?\t\t",
                  style: TextStyle(fontSize: 15, color: Color(0x33000000))),
              InkWell(
                child: const Text("Sign up",
                    style: TextStyle(fontSize: 15, color: Color(0xff1A374D))),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Signup()));
                },
              ),
            ],
          ),
          Container(
            height: 10,
          ),
        ],
      ),
    );
  }
}
