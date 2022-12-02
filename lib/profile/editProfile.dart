import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ipropertyplus/global/myText.dart';
import 'package:ipropertyplus/profile/editProfileTextField.dart';
import 'package:ipropertyplus/splashScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  EditProfilePageState createState() => EditProfilePageState();
}

bool codeRun = false;
String myID = "", mySecondID = "";

class EditProfilePageState extends State<EditProfilePage> {
  double stackHeight = 120;
  Color mainColor = const Color.fromRGBO(26, 55, 77, 1),
      secondColor = Colors.white,
      dividerColor = const Color.fromRGBO(224, 224, 229, 1);
  TextEditingController userNameController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPhoneNumberController = TextEditingController();
  TextEditingController userAddressController = TextEditingController();
  TextEditingController userCityController = TextEditingController();

  getSharedPreferencesUserData() async {
    SharedPreferences sharedPreferencesUserData =
        await SharedPreferences.getInstance();
    setState(() {
      myID = sharedPreferencesUserData.getString("userID")!;
      mySecondID = sharedPreferencesUserData.getString("userSecondID")!;
      codeRun = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (codeRun == false) getSharedPreferencesUserData();
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(myID)
              .collection("userData")
              .snapshots(),
          builder: (context, snapshot1) {
            userNameController.text = snapshot1.data?.docs[0]["userName"];
            userPasswordController.text =
                snapshot1.data?.docs[0]["userPassword"];
            userEmailController.text = snapshot1.data?.docs[0]["userEmail"];
            userPhoneNumberController.text =
                snapshot1.data?.docs[0]["userPhoneNumber"];
            userAddressController.text =
                (snapshot1.data?.docs[0]["userAddress"] == "")
                    ? "لا يوجد"
                    : snapshot1.data?.docs[0]["userAddress"];
            userCityController.text =
                (snapshot1.data?.docs[0]["userCity"] == "")
                    ? "لا يوجد"
                    : snapshot1.data?.docs[0]["userCity"];
            return (snapshot1.hasData != true)
                ? Align(
                    alignment: Alignment.center,
                    child:
                        MyText("No Connection", 22, mainColor, FontWeight.bold),
                  )
                : ListView(
                    children: [
                      Container(
                        height: stackHeight * (4 / 3),
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Stack(
                          children: [
                            Container(
                              height: stackHeight,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: mainColor,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.elliptical(
                                      stackHeight * 2, stackHeight * (2 / 3)),
                                  bottomRight: Radius.elliptical(
                                      stackHeight * 2, stackHeight * (2 / 3)),
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.logout,
                                      color: secondColor,
                                    ),
                                    onPressed: () async {
                                      SharedPreferences
                                          sharedPreferencesUserData =
                                          await SharedPreferences.getInstance();
                                      sharedPreferencesUserData
                                          .remove("signedUp");
                                      setState(() {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const SplashScreen()));
                                      });
                                    },
                                  ),
                                  Text(
                                    "حسابي",
                                    style: TextStyle(
                                        color: secondColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.arrow_forward,
                                      color: secondColor,
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: stackHeight / 2,
                              right: 50,
                              child: Stack(
                                children: [
                                  const CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    radius: 50,
                                  ),
                                  Positioned(
                                    top: 75,
                                    right: 75,
                                    child: Icon(
                                      Icons.edit,
                                      color: mainColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      EditProfileTextField("أسم المستخدم", userNameController),
                      EditProfileTextField("كلمة السر", userPasswordController),
                      EditProfileTextField("الحساب", userEmailController),
                      EditProfileTextField(
                          "رقم الهاتف", userPhoneNumberController),
                      EditProfileTextField("العنوان", userAddressController),
                      EditProfileTextField("المدينة", userCityController),
                      Divider(height: 5, thickness: 1, color: dividerColor),
                      GestureDetector(
                        onTap: () {
                          FirebaseFirestore.instance
                              .collection("users")
                              .doc(myID)
                              .collection("userData")
                              .doc(mySecondID)
                              .update(<String, dynamic>{
                            "userName": userNameController.text,
                            "userPassword": userPasswordController.text,
                            "userEmail": userEmailController.text,
                            "userPhoneNumber": userPhoneNumberController.text,
                            "userAddress": userAddressController.text,
                            "userCity": userCityController.text,
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 25),
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 50),
                          decoration: BoxDecoration(
                            color: mainColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Text(
                            "أحفظ",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: secondColor, fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  );
          }),
    );
  }
}
