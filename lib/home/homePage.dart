import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ipropertyplus/home/drawerPage.dart';
import 'package:ipropertyplus/home/notifications.dart';
import 'package:ipropertyplus/home/search.dart';
import 'package:ipropertyplus/posts/postField.dart';
import 'package:shared_preferences/shared_preferences.dart';

//This page to create SPLASH SCREEN.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

bool codeRun = false;

String myID = "", mySecondID = "";

class HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController profileTabBarController;

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
  void initState() {
    profileTabBarController = TabController(length: 7, vsync: this);
    super.initState();
  }

  Color mainColor = const Color.fromRGBO(26, 55, 77, 1),
      secondColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    if (codeRun == false) getSharedPreferencesUserData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        elevation: 0,
        title: Text(
          "iProperty",
          style: TextStyle(
            color: secondColor,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search_rounded,
              color: secondColor,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Search()));
            },
          ),
          IconButton(
            icon: Icon(
              Icons.notifications_rounded,
              color: secondColor,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Notifications()),
              );
            },
          ),
        ],
      ),
      drawer: DrawerPage(),
      body: Column(
        children: [
          Container(
            color: mainColor,
            child: TabBar(
              isScrollable: true,
              controller: profileTabBarController,
              labelColor: secondColor,
              indicatorColor: secondColor,
              tabs: const [
                Tab(
                  child: Text("شقق"),
                ),
                Tab(
                  child: Text("فيلات"),
                ),
                Tab(
                  child: Text("شاليهات"),
                ),
                Tab(
                  child: Text("منازل"),
                ),
                Tab(
                  child: Text("غرف"),
                ),
                Tab(
                  child: Text("عمارات"),
                ),
                Tab(
                  child: Text("مزارع"),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("peoplePosted")
                  .snapshots(),
              builder: (context, snapshot1) {
                return (snapshot1.hasData != true)
                    ? const Text("")
                    : ListView.builder(
                        itemCount: snapshot1.data?.docs.length,
                        itemBuilder: (context, index) {
                          return StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("users")
                                .doc(snapshot1.data?.docs[index]["userID"])
                                .collection("posts")
                                .snapshots(),
                            builder: (context, snapshot2) {
                              return (snapshot2.hasData != true)
                                  ? const Text("")
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      physics: const ClampingScrollPhysics(),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      itemCount: snapshot2.data?.docs.length,
                                      itemBuilder: (context, index2) {
                                        return (myID !=
                                                snapshot1.data!.docs[index]
                                                    ["userID"])
                                            ? Post(
                                                false,
                                                snapshot1.data!.docs[index]
                                                    ["userID"],
                                                snapshot2.data!.docs[index2]
                                                    ["userPostID"])
                                            : const Text("");
                                      },
                                    );
                            },
                          );
                        },
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
