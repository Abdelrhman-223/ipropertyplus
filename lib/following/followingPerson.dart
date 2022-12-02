import 'package:flutter/material.dart';

class FollowingPerson extends StatefulWidget {
  @override
  _FollowingPersonState createState() => _FollowingPersonState();
}

Color activeBorderColor = Color.fromRGBO(224, 224, 229, 1);

class _FollowingPersonState extends State<FollowingPerson> {
  Color mainColor = Color.fromRGBO(26, 55, 77, 1),
      supTextColor = Color.fromRGBO(26, 55, 77, .5),
      fieldBackgroundColor = Color.fromRGBO(224, 224, 229, 1),
      secondColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 85,
          height: 85,
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(
              color: activeBorderColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(50),
          ),
          child: GestureDetector(
            onTap: () {
              setState(() {
                if (activeBorderColor == Color.fromRGBO(224, 224, 229, 1)) {
                  activeBorderColor = Color.fromRGBO(26, 55, 77, 1);
                } else {
                  activeBorderColor = Color.fromRGBO(224, 224, 229, 1);
                }
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
