import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ipropertyplus/auth/login.dart';
import 'package:ipropertyplus/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

//This page to create SPLASH SCREEN.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  String brandName = "";

  @override
  void initState() {
    //Create initial state to make the timer start when code run.
    super.initState();
    Timer(const Duration(seconds: 2), () {
      setState(() {
        brandName = "iProperty";
      });
    });
    Timer(const Duration(seconds: 3), () async {
      //duration is the time to move the screen in this case it will take 2 seconds to disappear.
      SharedPreferences sharedPreferencesUserData =
          await SharedPreferences.getInstance();
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              (sharedPreferencesUserData.getBool("signedUp") == true)
                  ? const MyHomePage()
                  : Login(),
        ),
      );
    });
  }

  @override
  //here i right the code that will show at the splash screen.
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/logo.png",
                height: 150,
                width: 150,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                brandName,
                style: const TextStyle(color: Colors.grey, fontSize: 35),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
