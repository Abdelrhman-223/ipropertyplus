import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ipropertyplus/global/myDropdownButton.dart';
import 'package:ipropertyplus/global/myText.dart';
import 'package:ipropertyplus/global/myTextField.dart';
import 'package:ipropertyplus/global/switchField.dart';
import 'package:ipropertyplus/home/drawerPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  AddPostState createState() => AddPostState();
}

bool clear = false, checkId = false, checkPostImg = true;

class AddPostState extends State<AddPost> {
  File postImg = File("assets/images/logo.png");
  String choosesArea = "",
      choosesPropertyStatue = "",
      choosesPropertyType = "",
      userID = "",
      userSecondID = "",
      userPostID = "";
  List areas = ["القاهرة", "الجيزة", "الأسكندرية", "كفر الشيخ"],
      propertyStatue = ["بيع", "تأجير"],
      propertyType = ["شقة", "فيلا", "شاليه", "منزل", "غرفة", "عمارة", "مزرعة"];
  Color mainColor = const Color.fromRGBO(26, 55, 77, 1),
      supTextColor = const Color.fromRGBO(26, 55, 77, .5),
      fieldBackgroundColor = const Color.fromRGBO(224, 224, 229, 1),
      secondColor = Colors.white;
  TextEditingController postTitleController = TextEditingController();
  TextEditingController propertyAddressController = TextEditingController();
  TextEditingController postDescriptionController = TextEditingController();
  TextEditingController propertyPriceController = TextEditingController();
  TextEditingController propertyAreaController = TextEditingController();
  TextEditingController propertyRoomsNumberController = TextEditingController();
  TextEditingController propertyLoungeNumberController =
      TextEditingController();
  TextEditingController propertyFloorNumberController = TextEditingController();
  TextEditingController propertyKitchenNumberController =
      TextEditingController();
  TextEditingController propertyBathroomsNumberController =
      TextEditingController();

  void clearAddPge() {
    setState(() {
      postTitleController.clear();
      propertyAddressController.clear();
      postDescriptionController.clear();
      propertyPriceController.clear();
      propertyAreaController.clear();
      propertyRoomsNumberController.clear();
      propertyLoungeNumberController.clear();
      propertyFloorNumberController.clear();
      propertyKitchenNumberController.clear();
      propertyBathroomsNumberController.clear();
      selectedArea = "";
      selectedPropertyType = "";
      selectedPropertyStatue = "";
      checkElevator = "";
      checkPool = "";
      checkGarden = "";
      clear = true;
    });
    Timer(const Duration(seconds: 1), () {
      setState(() {
        clear = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        centerTitle: true,
        title: Text(
          'أضف إعلانك',
          style: TextStyle(fontSize: 20, color: secondColor),
        ),
      ),
      drawer: const DrawerPage(),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            GestureDetector(
              onTap: () async {
                ImagePicker camImg = ImagePicker();
                dynamic getImg =
                    await camImg.pickImage(source: ImageSource.camera);
                setState(() {
                  postImg = File(getImg.path);
                });
              },
              onDoubleTap: () async {
                ImagePicker camImg = ImagePicker();
                dynamic getImg =
                    await camImg.pickImage(source: ImageSource.gallery);
                setState(() {
                  postImg = File(getImg.path);
                });
              },
              onLongPress: () {
                setState(() {
                  checkPostImg = false;
                });
              },
              child: Container(
                height: 200,
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: fieldBackgroundColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: (checkPostImg)
                    ? Image.file(postImg)
                    : Icon(
                        Icons.add_photo_alternate_rounded,
                        color: mainColor,
                        size: 50,
                      ),
              ),
            ),
            MyText("أضغط مرة لألتقاط صورة.", 12, mainColor, FontWeight.normal),
            MyText("أضغط مرتين لأخذ صورة من المعرض.", 12, mainColor,
                FontWeight.normal),
            MyText(
                "أضغط مطولاً لحذف الصورة.", 12, mainColor, FontWeight.normal),
            MyTextField(
                "عنوان الإعلان", postTitleController, TextInputType.multiline),
            MyTextField("عنوان العقار", propertyAddressController,
                TextInputType.multiline),
            MyTextField("تفاصيل الإعلان", postDescriptionController,
                TextInputType.multiline),
            MyTextField("السعر", propertyPriceController, TextInputType.number),
            MyTextField(
                "المساحة", propertyAreaController, TextInputType.number),
            MyTextField("عدد الغرف", propertyRoomsNumberController,
                TextInputType.number),
            MyTextField("الصالات", propertyLoungeNumberController,
                TextInputType.number),
            MyTextField(
                "الطوابق", propertyFloorNumberController, TextInputType.number),
            MyTextField("المطابخ", propertyKitchenNumberController,
                TextInputType.number),
            MyTextField("الحمامات", propertyBathroomsNumberController,
                TextInputType.number),
            const SizedBox(height: 20),
            MyDropdownButton("المنطقة", areas, clear),
            MyDropdownButton("حالة العقار", propertyStatue, clear),
            MyDropdownButton("نوع العقار", propertyType, clear),
            const SizedBox(height: 20),
            SwitchField("مصعد كهربائي", clear),
            SwitchField("حمام سباحة", clear),
            SwitchField("حديقة", clear),
            const SizedBox(height: 20),
            MyText("العنوان علي الخريطة", 18, mainColor, FontWeight.normal),
            GestureDetector(
              child: Container(
                height: 200,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: fieldBackgroundColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  Icons.add_location_alt_rounded,
                  color: mainColor,
                  size: 50,
                ),
              ),
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("peoplePosted")
                    .snapshots(),
                builder: (context, snapshot) {
                  for (int i = 0; i < snapshot.data!.docs.length; i++) {
                    if (userID == snapshot.data?.docs[i]["userID"]) {
                      checkId = true;
                    }
                  }
                  return const Text("");
                }),
            GestureDetector(
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: MyText("نشر", 22, secondColor, FontWeight.normal),
              ),
              onTap: () async {
                SharedPreferences sharedPreferencesUserData =
                    await SharedPreferences.getInstance();
                userID = sharedPreferencesUserData.getString("userID")!;
                if (checkId == false) {
                  FirebaseFirestore.instance
                      .collection("peoplePosted")
                      .add(<String, dynamic>{"userID": userID});
                }
                userPostID = FirebaseFirestore.instance
                    .collection("users")
                    .doc(userID)
                    .collection("posts")
                    .doc()
                    .id;
                userSecondID = FirebaseFirestore.instance
                    .collection("users")
                    .doc(userID)
                    .collection("userData")
                    .doc()
                    .id;
                FirebaseFirestore.instance
                    .collection("users")
                    .doc(userID)
                    .collection("posts")
                    .doc(userPostID)
                    .set(<String, dynamic>{
                  "userPostID": userPostID,
                });
                FirebaseFirestore.instance
                    .collection("users")
                    .doc(userID)
                    .collection("posts")
                    .doc(userPostID)
                    .update(<String, dynamic>{
                  "postTitle": (postTitleController.text == "")
                      ? "غير محدد"
                      : postTitleController.text,
                  "propertyAddress": (propertyAddressController.text == "")
                      ? "غير محدد"
                      : propertyAddressController.text,
                  "postDescription": (postDescriptionController.text == "")
                      ? "غير محدد"
                      : postDescriptionController.text,
                  "propertyPrice": (propertyPriceController.text == "")
                      ? "غير محدد"
                      : propertyPriceController.text,
                  "propertyArea": (propertyAreaController.text == "")
                      ? "غير محدد"
                      : propertyAreaController.text,
                  "propertyRoomsNumber":
                      (propertyRoomsNumberController.text == "")
                          ? "غير محدد"
                          : propertyRoomsNumberController.text,
                  "propertyLoungeNumber":
                      (propertyLoungeNumberController.text == "")
                          ? "غير محدد"
                          : propertyLoungeNumberController.text,
                  "propertyFloorNumber":
                      (propertyFloorNumberController.text == "")
                          ? "غير محدد"
                          : propertyFloorNumberController.text,
                  "propertyKitchenNumber":
                      (propertyKitchenNumberController.text == "")
                          ? "غير محدد"
                          : propertyKitchenNumberController.text,
                  "propertyBathroomsNumber":
                      (propertyBathroomsNumberController.text == "")
                          ? "غير محدد"
                          : propertyBathroomsNumberController.text,
                  "area": (MyDropdownButtonState().returnSelectedArea() == "")
                      ? "غير محدد"
                      : MyDropdownButtonState().returnSelectedArea(),
                  "propertyStatue": (MyDropdownButtonState()
                              .returnSelectedPropertyStatue() ==
                          "")
                      ? "غير محدد"
                      : MyDropdownButtonState().returnSelectedPropertyStatue(),
                  "propertyType": (MyDropdownButtonState()
                              .returnSelectedPropertyType() ==
                          "")
                      ? "غير محدد"
                      : MyDropdownButtonState().returnSelectedPropertyType(),
                  "checkElevator": SwitchFieldState().returnCheckElevator(),
                  "checkPool": SwitchFieldState().returnCheckPool(),
                  "checkGarden": SwitchFieldState().returnCheckGarden(),
                });
                FirebaseFirestore.instance
                    .collection("users")
                    .doc(userID)
                    .collection("userData")
                    .doc(userSecondID)
                    .update(<String, dynamic>{
                  "checkPosted": "true",
                });
                setState(() {
                  clearAddPge();
                });
              },
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  clearAddPge();
                });
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red, width: 2),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: MyText("إهمال", 22, Colors.red, FontWeight.normal),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
