import 'package:flutter/material.dart';
import 'package:ipropertyplus/chat/technicalSupport.dart';
import 'package:ipropertyplus/home/about.dart';
import 'package:ipropertyplus/home/log.dart';
import 'package:ipropertyplus/home/settings.dart';
import 'package:ipropertyplus/posts/favoritePosts.dart';
import 'package:ipropertyplus/report/report.dart';

// ignore: must_be_immutable
class DrawerListTile extends StatefulWidget {
  String listTileName;
  IconData listTileIcon;

  DrawerListTile(this.listTileName, this.listTileIcon);

  @override
  _DrawerListTileState createState() => _DrawerListTileState();
}

class _DrawerListTileState extends State<DrawerListTile> {
  Color mainColor = Color.fromRGBO(26, 55, 77, 1),
      secondColor = Colors.white,
      dividerColor = Color.fromRGBO(224, 224, 229, 1);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        widget.listTileIcon,
        color: mainColor,
      ),
      title: Text(
        widget.listTileName,
        style: TextStyle(color: mainColor),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => (widget.listTileName == "المفضلة")
                  ? FavoritePosts()
                  : (widget.listTileName == "السجل")
                      ? Log()
                      : (widget.listTileName == "الإعدادات")
                          ? Settings()
                          : (widget.listTileName == "الدعم الفني")
                              ? TechnicalSupport()
                              : (widget.listTileName == "تقديم شكوى")
                                  ? Report()
                                  : About(),
            ));
      },
    );
  }
}
