import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MessageField extends StatelessWidget {
  String checkType, message;

  MessageField(this.message, this.checkType);

  double maxHeight = 500, maxWidth = 250;
  Alignment fieldAlignment = Alignment.centerLeft;
  Color fieldBackgroundColor = Color.fromRGBO(224, 224, 229, 1),
      mainColor = Color.fromRGBO(26, 55, 77, 1);

  @override
  Widget build(BuildContext context) {
    if (checkType == "send") {
      fieldAlignment = Alignment.centerRight;
      fieldBackgroundColor = Color.fromRGBO(159, 171, 184, 1);
    }
    return GestureDetector(
      child: FittedBox(
        fit: BoxFit.values[6],
        alignment: fieldAlignment,
        child: Container(
          width: 250,
          margin: EdgeInsets.symmetric(vertical: 2),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: fieldBackgroundColor,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Text(
            message,
            softWrap: true,
            style: TextStyle(
              color: mainColor,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
