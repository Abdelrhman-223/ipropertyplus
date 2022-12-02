import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  get myFocusNode => null;
  TextEditingController searchController = new TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xff1A374D),
          title: Container(
            height: 40,
            width: double.infinity,
            padding: EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(50)),
            child: Center(
              child: TextField(
                textAlign: TextAlign.right,
                cursorColor: Color(0xff1A374D),
                style: TextStyle(color: Color(0xff1A374D)),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 2, top: 2),
                    suffixIcon: Icon(Icons.search, color: Color(0xff1A374D)),
                    hintText: 'بحث',
                    hintStyle: TextStyle(color: Color(0x80000000)),
                    border: InputBorder.none),
                textInputAction: TextInputAction.search,
                onSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(myFocusNode),
              ),
            ),
          )),
    );
  }
}
