import 'package:flutter/material.dart';

Widget AppSlider(
  BuildContext context, {
  String? lable,
  required double max,
  required double min,
  required double value,
  Function(double)? onChanged,
  Function(double)? onChangeEnd,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      lable == null ? Container() : Text(lable),
      Container(
        child: Slider(
          activeColor: Theme.of(context).primaryColor,
          inactiveColor: Theme.of(context).primaryColor,
          value: value,
          max: max,
          min: min,
          divisions: max.toInt() * 10,
          label: value.toStringAsFixed(2),
          onChangeEnd: (value) {
            if (onChangeEnd != null) {
              onChangeEnd(value);
            }
          },
          onChanged: (double value) {
            if (onChanged != null) {
              onChanged(value);
            }
          },
        ),
      ),
    ],
  );
}
