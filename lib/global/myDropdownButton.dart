import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyDropdownButton extends StatefulWidget {
  List areas;
  bool clear;
  String dropdownButtonName;

  MyDropdownButton(this.dropdownButtonName, this.areas, this.clear,
      {super.key});

  @override
  MyDropdownButtonState createState() => MyDropdownButtonState();
}

String selectedArea = "",
    selectedPropertyStatue = "",
    selectedPropertyType = "";

class MyDropdownButtonState extends State<MyDropdownButton> {
  String? dropdownMenuItemVale;
  Color mainColor = const Color.fromRGBO(26, 55, 77, 1),
      supTextColor = const Color.fromRGBO(26, 55, 77, .5),
      fieldBackgroundColor = const Color.fromRGBO(224, 224, 229, 1),
      secondColor = Colors.white;

  returnSelectedArea() {
    return selectedArea;
  }

  returnSelectedPropertyStatue() {
    return selectedPropertyStatue;
  }

  returnSelectedPropertyType() {
    return selectedPropertyType;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.clear == true) dropdownMenuItemVale = widget.areas[0];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: fieldBackgroundColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: DropdownButton(
        iconSize: 40,
        isDense: true,
        isExpanded: true,
        focusColor: supTextColor,
        value: (dropdownMenuItemVale == null)? widget.areas[0]: dropdownMenuItemVale,
        iconEnabledColor: mainColor,
        iconDisabledColor: supTextColor,
        dropdownColor: fieldBackgroundColor,
        hint: Text(
          widget.dropdownButtonName,
          style: TextStyle(
            color: supTextColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        items: widget.areas.map((element) {
          return DropdownMenuItem(
            value: element,
            child: Text(
              element,
              style: TextStyle(
                color: mainColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            dropdownMenuItemVale = value.toString();
            if (widget.dropdownButtonName == "المنطقة") {
              selectedArea = value.toString();
            } else if (widget.dropdownButtonName == "حالة العقار") {
              selectedPropertyStatue = value.toString();
            } else if (widget.dropdownButtonName == "نوع العقار") {
              selectedPropertyType = value.toString();
            }
          });
        },
      ),
    );
  }
}
