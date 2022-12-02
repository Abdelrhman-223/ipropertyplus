import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyTextField extends StatelessWidget {
  String fieldText;
  dynamic addPostKeyboardType;
  TextEditingController myTextFieldController;
  Color mainColor = Color.fromRGBO(26, 55, 77, 1),
      supTextColor = Color.fromRGBO(26, 55, 77, .5),
      fieldBackgroundColor = Color.fromRGBO(224, 224, 229, 1),
      secondColor = Colors.white,
      dividerColor = Color.fromRGBO(224, 224, 229, 1);

  MyTextField(
      this.fieldText, this.myTextFieldController, this.addPostKeyboardType);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      child: TextField(
        cursorColor: mainColor,
        controller: myTextFieldController,
        keyboardType: addPostKeyboardType,
        textAlignVertical: TextAlignVertical.top,
        style: TextStyle(
          color: mainColor,
          fontSize: 20,
        ),
        decoration: InputDecoration(
          hintText: fieldText,
          hintStyle: TextStyle(
            color: supTextColor,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: supTextColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: mainColor),
          ),
        ),
      ),
    );
  }
}
