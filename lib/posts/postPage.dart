import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ipropertyplus/global/myText.dart';
import 'package:ipropertyplus/posts/comments.dart';
import 'package:ipropertyplus/profile/personProfile.dart';

import 'addFavoriteButton.dart';

// ignore: must_be_immutable
class PostPage extends StatefulWidget {
  String userID, userPostID;

  PostPage(this.userID, this.userPostID, {super.key});

  @override
  PostPageState createState() => PostPageState();
}

bool checkHeartIcon = false;

class PostPageState extends State<PostPage> {
  double dividerHeight = 25, fontSize18 = 18;
  Icon heartIcon = const Icon(Icons.favorite_border_rounded);
  Color mainColor = const Color.fromRGBO(26, 55, 77, 1),
      supTextColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(widget.userID)
              .collection("userData")
              .snapshots(),
          builder: (context, snapshot1) {
            return (snapshot1.hasData != true)
                ? const Text("")
                : StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("users")
                        .doc(widget.userID)
                        .collection("posts")
                        .doc(widget.userPostID)
                        .snapshots(),
                    builder: (context, snapshot2) {
                      return (snapshot2.hasData != true)
                          ? const Text("")
                          : ListView(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        AddFavoriteButton(false, widget.userID,
                                            widget.userPostID),
                                        IconButton(
                                          icon: Icon(
                                            Icons.share_rounded,
                                            color: mainColor,
                                          ),
                                          onPressed: () {},
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.arrow_forward,
                                        color: mainColor,
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 200,
                                  margin: const EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: const DecorationImage(
                                      image:
                                          AssetImage("assets/images/logo.png"),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    MyText(snapshot2.data!["postTitle"], 20,
                                        mainColor, FontWeight.bold),
                                    MyText(
                                        "${snapshot2.data!["propertyPrice"]} جنيه ",
                                        20,
                                        mainColor,
                                        FontWeight.bold),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.watch_later_outlined,
                                          color: mainColor,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        MyText("تاريخ النشر", 14, mainColor,
                                            FontWeight.bold)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_pin,
                                          color: mainColor,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        MyText(
                                            snapshot2.data!["propertyAddress"],
                                            14,
                                            mainColor,
                                            FontWeight.bold),
                                      ],
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: supTextColor,
                                  thickness: 1,
                                  height: dividerHeight,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PersonProfilePage(
                                                      widget.userID,
                                                      snapshot1.data?.docs[0]
                                                          ["userSecondID"]),
                                            ));
                                      },
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: mainColor,
                                            radius: 25,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          MyText(
                                              snapshot1.data?.docs[0]
                                                  ["userName"],
                                              20,
                                              mainColor,
                                              FontWeight.bold),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.message_rounded,
                                        color: mainColor,
                                        size: 30,
                                      ),
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: supTextColor,
                                  thickness: 1,
                                  height: dividerHeight,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        MyText("نوع العقار:", fontSize18,
                                            mainColor, FontWeight.normal),
                                        const SizedBox(
                                          width: 25,
                                        ),
                                        MyText(
                                            snapshot2.data!["propertyType"],
                                            fontSize18,
                                            mainColor,
                                            FontWeight.bold),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        MyText("حالة العقار:", fontSize18,
                                            mainColor, FontWeight.normal),
                                        const SizedBox(
                                          width: 25,
                                        ),
                                        MyText(
                                            snapshot2.data!["propertyStatue"],
                                            fontSize18,
                                            mainColor,
                                            FontWeight.bold),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        MyText("المساحة:", fontSize18,
                                            mainColor, FontWeight.normal),
                                        const SizedBox(
                                          width: 25,
                                        ),
                                        MyText(
                                            snapshot2.data!["propertyArea"],
                                            fontSize18,
                                            mainColor,
                                            FontWeight.bold),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        MyText("عدد الغرف:", fontSize18,
                                            mainColor, FontWeight.normal),
                                        const SizedBox(
                                          width: 25,
                                        ),
                                        MyText(
                                            snapshot2
                                                .data!["propertyRoomsNumber"],
                                            fontSize18,
                                            mainColor,
                                            FontWeight.bold),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        MyText("عدد الحمامات:", fontSize18,
                                            mainColor, FontWeight.normal),
                                        const SizedBox(
                                          width: 25,
                                        ),
                                        MyText(
                                            snapshot2.data![
                                                "propertyBathroomsNumber"],
                                            fontSize18,
                                            mainColor,
                                            FontWeight.bold),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        MyText("مصعد كهربائي:", fontSize18,
                                            mainColor, FontWeight.normal),
                                        const SizedBox(
                                          width: 25,
                                        ),
                                        MyText(
                                            (snapshot2.data!["checkElevator"] ==
                                                        null ||
                                                    snapshot2.data![
                                                            "checkElevator"] ==
                                                        "")
                                                ? "لا يوجد"
                                                : snapshot2
                                                    .data!["checkElevator"],
                                            fontSize18,
                                            mainColor,
                                            FontWeight.bold),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        MyText("حمام سباحة:", fontSize18,
                                            mainColor, FontWeight.normal),
                                        const SizedBox(
                                          width: 25,
                                        ),
                                        MyText(
                                            (snapshot2.data!["checkPool"] ==
                                                        null ||
                                                    snapshot2.data![
                                                            "checkPool"] ==
                                                        "")
                                                ? "لا يوجد"
                                                : snapshot2.data!["checkPool"],
                                            fontSize18,
                                            mainColor,
                                            FontWeight.bold),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        MyText("حديقة:", fontSize18, mainColor,
                                            FontWeight.normal),
                                        const SizedBox(
                                          width: 25,
                                        ),
                                        MyText(
                                            (snapshot2.data!["checkGarden"] ==
                                                        null ||
                                                    snapshot2.data![
                                                            "checkGarden"] ==
                                                        "")
                                                ? "لا يوجد"
                                                : snapshot2
                                                    .data!["checkGarden"],
                                            fontSize18,
                                            mainColor,
                                            FontWeight.bold),
                                      ],
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: supTextColor,
                                  thickness: 1,
                                  height: dividerHeight,
                                ),
                                Row(
                                  children: [
                                    MyText("وصف الإعلان:", fontSize18,
                                        mainColor, FontWeight.normal),
                                    const SizedBox(
                                      width: 25,
                                    ),
                                    SizedBox(
                                      width: 200,
                                      child: MyText(
                                          snapshot2.data!["postDescription"],
                                          fontSize18,
                                          mainColor,
                                          FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: supTextColor,
                                  thickness: 1,
                                  height: dividerHeight,
                                ),
                                MyText("العنوان علي الخريطة:", fontSize18,
                                    mainColor, FontWeight.normal),
                                Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                    color: mainColor,
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: const GoogleMap(
                                    liteModeEnabled: false,
                                    myLocationButtonEnabled: true,
                                    initialCameraPosition: CameraPosition(
                                      zoom: 6,
                                      target: LatLng(29, 29),
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: supTextColor,
                                  thickness: 1,
                                  height: dividerHeight,
                                ),
                                MyText("التعليقات:", fontSize18, mainColor,
                                    FontWeight.normal),
                                TextButton(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: MyText("اضغط لرؤية باقي التعليقات",
                                        16, mainColor, FontWeight.normal),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Comments()),
                                    );
                                  },
                                ),
                              ],
                            );
                    },
                  );
          },
        ),
      ),
    );
  }
}
