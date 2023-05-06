import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MySlider extends StatefulWidget {
  final String title;
  final String id;
  double value;
  final double defaultValue;
  final bool isEnableChangeData;
  final Function({String? key, Object? value}) updateData;
  final List<Text> scale;

  MySlider({Key? key, required this.value, required this.isEnableChangeData, required this.title, required this.scale, required this.updateData, required this.id, required this.defaultValue}) : super(key: key);

  @override
  State<MySlider> createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {

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
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    widget.value.toString(),
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
          StatefulBuilder(
            builder: (context, state) => Container(
              child: Slider(
                activeColor: widget.isEnableChangeData? Colors.indigo : Colors.grey[300],
                value: widget.value,
                min: 0.0,
                max: 100.0,
                onChanged: (val) {
                  state(() {
                    if (widget.isEnableChangeData) {
                      widget.value = val;
                      if (widget.defaultValue != val) {
                        widget.updateData(key: widget.id, value: val.toInt());
                      }
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
