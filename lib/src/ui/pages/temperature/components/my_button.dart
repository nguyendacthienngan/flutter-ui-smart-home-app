import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {
  const MyButton({
    Key? key,
    required this.title,
    required this.selectItem,
    required this.isEnabled,
    required this.index,
    required this.enableChangingData
  }) : super(key: key);

  final String title;
  final bool isEnabled;
  final Function(int) selectItem;
  final Function(String) enableChangingData;
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
        widget.enableChangingData(widget.title);
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