import 'package:flutter/material.dart';

import 'my_button.dart';

class MySelectButton extends StatefulWidget {

  final Function(String) enableChangingData;

  MySelectButton({Key? key, required this.enableChangingData}) : super(key: key);

  @override
  State<MySelectButton> createState() => _MySelectButtonState();
}

class _MySelectButtonState extends State<MySelectButton> {
  int _selectedItem = 0;

  selectItem(index) {
    setState(() {
      _selectedItem = index;
      print(selectItem.toString());
    });
  }


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MyButton(
          index: 0,
          title: 'GENERAL',
          selectItem: selectItem,
          isEnabled: _selectedItem == 0,
          enableChangingData: widget.enableChangingData
        ),
        MyButton(
          index: 1,
          title: 'SERVICES',
          selectItem: selectItem,
          isEnabled:  _selectedItem == 1,
          enableChangingData: widget.enableChangingData
        )
      ],
    );
  }
}
