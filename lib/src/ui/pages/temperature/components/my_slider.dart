import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MySlider extends StatefulWidget {
  final List<Text> scale;
  final String title;
  double value;
  final bool isEnableChangeData;
  MySlider({Key? key, required this.value, required this.isEnableChangeData, required this.title, required this.scale}) : super(key: key);

  @override
  State<MySlider> createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  double brightness = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              widget.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          StatefulBuilder(
            builder: (context, state) => Container(
              child: Slider(
                value: widget.value,
                min: 0.0,
                max: 100.0,
                onChanged: (val) {
                  state(() {
                    if (widget.isEnableChangeData) {
                      widget.value = val;
                    }
                  });
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: widget.scale
            ),
          )
        ],
      ),
    );
  }
}
