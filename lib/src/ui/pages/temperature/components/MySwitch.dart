import 'package:flutter/material.dart';

class MySwitch extends StatefulWidget {
  final String id;
  final String title;
  late double value;
  final Function({String? key, Object? value}) updateData;

  MySwitch({Key? key, required this.value, required this.updateData, required this.id, required this.title}) : super(key: key);

  @override
  State<MySwitch> createState() => _MySwitchState();
}

class _MySwitchState extends State<MySwitch> {
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
                  child:  Align(
                    alignment: Alignment.topRight,
                    child: Switch(
                        value: (widget.value == 0) ? false: true ,
                        onChanged: (value) {
                          setState(() {
                            widget.value = (value)? 1 : 0;
                            widget.updateData(key: widget.id, value: widget.value.toInt());
                          });
                        }),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
