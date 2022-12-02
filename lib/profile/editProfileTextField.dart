import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EditProfileTextField extends StatefulWidget {
  String fieldText;
  TextEditingController myTextFieldController = TextEditingController();

  EditProfileTextField(this.fieldText, this.myTextFieldController, {super.key});

  @override
  State<EditProfileTextField> createState() => _EditProfileTextFieldState();
}

class _EditProfileTextFieldState extends State<EditProfileTextField> {
  Color mainColor = const Color.fromRGBO(26, 55, 77, 1),
      secondColor = Colors.white,
      dividerColor = const Color.fromRGBO(224, 224, 229, 1);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
        color: dividerColor,
        width: 1,
      ))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "${widget.fieldText}:",
            style: TextStyle(
                color: mainColor, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 220,
            child: TextField(
              controller: widget.myTextFieldController,
              cursorColor: mainColor,
              style: TextStyle(
                color: mainColor,
                fontSize: 20,
              ),
              decoration: null,
            ),
          ),
        ],
      ),
    );
  }
}
