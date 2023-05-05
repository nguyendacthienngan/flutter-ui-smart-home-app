import 'package:flutter/material.dart';

class MySlider extends StatefulWidget {
  double lightControl;
  final bool isEnableChangeData;
  MySlider({Key? key, required this.lightControl, required this.isEnableChangeData}) : super(key: key);

  @override
  State<MySlider> createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  @override
  Widget build(BuildContext context) {
    return Slider(
      value: widget.lightControl,
      onChanged: (newHeating) {
        if (widget.isEnableChangeData) {
          setState(() => widget.lightControl = newHeating);
        }
      },
      max: 100,
    );
  }
}
