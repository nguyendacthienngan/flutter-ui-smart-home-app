import 'package:flutter/material.dart';

class MySelectButton extends StatefulWidget {


  MySelectButton({Key? key}) : super(key: key);

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
            isEnabled: _selectedItem == 0
        ),
        MyButton(
          index: 1,
          title: 'SERVICES',
            selectItem: selectItem,
            isEnabled:  _selectedItem == 1
        )
      ],
    );
  }
}

class MyButton extends StatefulWidget {
  MyButton({
    Key? key,
    required this.title,
    required this.selectItem,
    required this.isEnabled,
    required this.index
  }) : super(key: key);

  final String title;
  final bool isEnabled;
  final Function(int) selectItem;
  final int index;

  set _isEnabled(bool _isEnabled) {}

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {

  void _toggleEnabled() {
    setState(() {
      // widget._isEnabled = !widget.isEnabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        widget.selectItem(widget.index);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.isEnabled ? Colors.indigo : Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24)
        )
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 32,
        ),
        child: Text(
          widget.title,
          style: TextStyle(
            color: widget.isEnabled ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

}