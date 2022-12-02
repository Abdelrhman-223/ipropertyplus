import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ipropertyplus/posts/addFavoriteButton.dart';
import 'package:ipropertyplus/posts/postPage.dart';

// ignore: must_be_immutable
class Post extends StatefulWidget {
  bool cameFromFavorite;
  String userID, userPostID;

  Post(this.cameFromFavorite, this.userID, this.userPostID, {super.key});

  @override
  PostState createState() => PostState();
}

class PostState extends State<Post> {
  Color mainColor = const Color.fromRGBO(26, 55, 77, 1),
      supTextColor = Colors.grey,
      fieldBackgroundColor = const Color.fromRGBO(224, 224, 229, 1);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
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
                      : GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PostPage(
                                        widget.userID, widget.userPostID)));
                          },
                          child: Container(
                            height: 350,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 10,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 200,
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: 200,
                                        margin:
                                            const EdgeInsets.only(bottom: 10),
                                        decoration: BoxDecoration(
                                          color: fieldBackgroundColor,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          image: const DecorationImage(
                                            image: AssetImage(
                                                "assets/images/logo.png"),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        child: AddFavoriteButton(
                                            widget.cameFromFavorite,
                                            widget.userID,
                                            widget.userPostID),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 130,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            snapshot2.data!["postTitle"],
                                            softWrap: true,
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: mainColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "${snapshot2.data!["propertyPrice"]} جنيه",
                                            softWrap: true,
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: mainColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "حالة العقار: ${snapshot2.data!["propertyStatue"]}",
                                        softWrap: true,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: supTextColor,
                                        ),
                                      ),
                                      Text(
                                        "أسم المعلن: ${snapshot1.data?.docs[0]["userName"]}",
                                        softWrap: true,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: supTextColor,
                                        ),
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
                                              Text(
                                                "تاريخ النشر",
                                                softWrap: true,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: mainColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
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
                                              Text(
                                                snapshot2
                                                    .data!["propertyAddress"],
                                                softWrap: true,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: mainColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                },
              );
      },
    );
  }
}
