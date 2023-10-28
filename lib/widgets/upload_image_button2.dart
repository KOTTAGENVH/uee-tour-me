import 'package:flutter/material.dart';
import 'package:tour_me/constants.dart';

class UploadImageButton2 extends StatelessWidget {
  final VoidCallback onPress;
  final String text;
  final Icon? icon; // Accept an optional Icon

  const UploadImageButton2({
    Key? key,
    required this.onPress,
    required this.text,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
          bottom: 40, top: 40), // Set your desired margin value
      child: ElevatedButton(
        onPressed: onPress,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            MyColors.ash,
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  16.0), // You can adjust the radius as needed
              side: const BorderSide(
                color: MyColors.pink, // Border color
                width: 1.0, // Border width
              ),
            ),
          ),
          minimumSize: MaterialStateProperty.all<Size>(const Size(150, 37)),
          // shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          //   RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(16.0),
          //   ),
          // ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (icon != null) icon!,
            if (icon != null) const SizedBox(width: 10),
            // Show the icon if it's provided
            Text(text),
          ],
        ),
      ),
    );
  }
}
