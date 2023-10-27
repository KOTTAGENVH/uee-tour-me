import 'package:flutter/material.dart';
import 'package:tour_me/constants.dart';

class LabeledEmptyDivider extends StatelessWidget {
  final double leftPadding;
  final double rightPadding;
  final double thickness;
  final Color color;

  const LabeledEmptyDivider({
    Key? key,
    this.thickness = 1.5,
    this.color = MyColors.pink,
    required this.leftPadding,
    required this.rightPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: leftPadding, right: rightPadding),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Divider(
              thickness: thickness,
              color: color,
            ),
          ),
          Expanded(
            child: Divider(
              thickness: thickness,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
