import 'package:flutter/material.dart';
import 'package:tour_me/constants.dart';

class LabeledDivider extends StatelessWidget {
  final String label;
  final double thickness;
  final double labelPadding;
  final Color color;

  const LabeledDivider({
    super.key,
    required this.label,
    this.thickness = 1.5,
    this.labelPadding = 8.0,
    this.color = MyColors.pink,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Divider(
            thickness: thickness,
            color: color,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: labelPadding),
          child: Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            thickness: thickness,
            color: color,
          ),
        ),
      ],
    );
  }
}
