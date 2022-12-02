import 'package:flutter/material.dart';

import 'myText.dart';

// ignore: must_be_immutable
class SwitchField extends StatefulWidget {
  String switchName;
  bool clear;

  SwitchField(this.switchName, this.clear, {super.key});

  @override
  SwitchFieldState createState() => SwitchFieldState();
}

String checkElevator = "", checkPool = "", checkGarden = "";

class SwitchFieldState extends State<SwitchField> {
  bool activeSwitch = false;
  Color mainColor = const Color.fromRGBO(26, 55, 77, 1),
      supTextColor = const Color.fromRGBO(26, 55, 77, .5),
      fieldBackgroundColor = const Color.fromRGBO(224, 224, 229, 1),
      secondColor = Colors.white;

  String returnCheckElevator() {
    return checkElevator;
  }

  String returnCheckPool() {
    return checkPool;
  }

  String returnCheckGarden() {
    return checkGarden;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.clear == true) activeSwitch = false;
    return Container(
      padding: const EdgeInsets.only(right: 15),
      margin: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        color: fieldBackgroundColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyText(widget.switchName, 18, mainColor, FontWeight.bold),
          Switch(
            value: activeSwitch,
            focusColor: mainColor,
            activeColor: mainColor,
            onChanged: (value) {
              setState(() {
                if (activeSwitch == false) {
                  activeSwitch = true;
                  if (widget.switchName == "مصعد كهربائي") {
                    checkElevator = "يوجد";
                  } else if (widget.switchName == "حمام سباحة") {
                    checkPool = "يوجد";
                  } else if (widget.switchName == "حديقة") {
                    checkGarden = "يوجد";
                  }
                } else {
                  activeSwitch = false;
                  if (widget.switchName == "مصعد كهربائي") {
                    checkElevator = "لا يوجد";
                  } else if (widget.switchName == "حمام سباحة") {
                    checkPool = "لا يوجد";
                  } else if (widget.switchName == "حديقة") {
                    checkGarden = "لا يوجد";
                  }
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
