import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  String theText;
  double textSize;
  Color textColor;
  FontWeight textWeight;

  MyText(this.theText, this.textSize, this.textColor, this.textWeight);

  @override
  Widget build(BuildContext context) {
    return Text(
      theText,
      softWrap: true,
      style: TextStyle(
        fontSize: textSize,
        color: textColor,
        fontWeight: textWeight,
      ),
    );
  }
}
