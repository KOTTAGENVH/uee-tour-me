import 'package:flutter/material.dart';
import 'package:tour_me/constants.dart';

class TopNav extends StatelessWidget {
  const TopNav({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: const EdgeInsets.only(top: 70, left: 20),
      child: Row(
        children: [
          Image.asset(MyImages.iconLogo, scale: 30),
          Expanded(child: Container()),
          Container(
            margin: const EdgeInsets.only(right: 20),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }
}