import 'package:flutter/material.dart';
import 'package:tour_me/constants.dart';

class PinkButton extends StatelessWidget {
  final VoidCallback onPress;
  final String text;
  const PinkButton({
    super.key,
    required this.onPress,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          MyColors.pink,
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
      ),
      child: Text(text),
    );
  }
}
