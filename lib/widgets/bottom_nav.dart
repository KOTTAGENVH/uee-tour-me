import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return  const GNav(rippleColor: Color(0xFFFF5A6E), // tab button ripple color when pressed
  hoverColor: Color(0xFFFF5A6E), // tab button hover color
  haptic: true, // haptic feedback
  tabBorderRadius: 15, 
  //tabActiveBorder: Border.all(color: const Color.fromARGB(255, 255, 255, 255), width: 1), // tab button border
  //tabBorder: Border.all(color: const Color.fromARGB(255, 255, 255, 255), width: 1), // tab button border
  //tabShadow: [BoxShadow(color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.5), blurRadius: 8)], // tab button shadow
  curve: Curves.easeOutExpo, // tab animation curves
  duration:  Duration(milliseconds: 500), // tab animation duration
  gap: 5, // the tab button gap between icon and text 
  color:  Color.fromARGB(255, 255, 255, 255), // unselected icon color
  activeColor: Color.fromARGB(255, 255, 255, 255), // selected icon and text color
  iconSize: 32, // tab button icon size
  tabBackgroundColor: Color(0xFFFF5A6E), // selected tab background color
  padding:  EdgeInsets.symmetric(horizontal: 20, vertical: 5), // navigation bar padding
  tabs:  [
     GButton(
      icon: Icons.home,
      margin: EdgeInsets.all(10),
      padding:EdgeInsets.all(10),
      text: 'Home',
    ),
    GButton(
      icon: Icons.favorite,
      margin: EdgeInsets.all(10),
      padding:EdgeInsets.all(10),
      text: 'Favourite',
    ),
     GButton(
      icon: Icons.list_alt,
      margin: EdgeInsets.all(10),
      padding:EdgeInsets.all(10),
      text: 'Wishlist',
    ),
     GButton(
      icon: Icons.add_circle,
      margin: EdgeInsets.all(10),
      padding:EdgeInsets.all(10),
      text: 'Plan',
    )
  ]
);
  }
}