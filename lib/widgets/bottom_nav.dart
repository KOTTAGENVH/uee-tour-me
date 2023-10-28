import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:tour_me/pages/traveller_create_trip.dart';
import 'package:tour_me/pages/traveller_home.dart';
import 'package:tour_me/pages/wishlist.dart';

class BottomNav extends StatelessWidget {
  final Selections selcted;
  static const List<Selections> selectionList = [
    Selections.home,
    Selections.favorite,
    Selections.wishlist,
    Selections.add,
  ];
  const BottomNav({
    super.key,
    this.selcted = Selections.home,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: GNav(
        selectedIndex: selectionList.indexOf(selcted),
        rippleColor: const Color(0xFFFF5A6E), // tab button ripple color when pressed
        hoverColor: const Color(0xFFFF5A6E), // tab button hover color
        haptic: true, // haptic feedback
        tabBorderRadius: 15,
        //tabActiveBorder: Border.all(color: const Color.fromARGB(255, 255, 255, 255), width: 1), // tab button border
        //tabBorder: Border.all(color: const Color.fromARGB(255, 255, 255, 255), width: 1), // tab button border
        //tabShadow: [BoxShadow(color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.5), blurRadius: 8)], // tab button shadow
        curve: Curves.easeOutExpo, // tab animation curves
        duration: const Duration(milliseconds: 500), // tab animation duration
        gap: 5, // the tab button gap between icon and text
        color: const Color.fromARGB(255, 255, 255, 255), // unselected icon color
        activeColor: const Color.fromARGB(255, 255, 255, 255), // selected icon and text color
        iconSize: 32, // tab button icon size
        tabBackgroundColor: const Color(0xFFFF5A6E), // selected tab background color
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5), // navigation bar padding
        tabs: [
          GButton(
            icon: Icons.home,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            text: 'Home',
            onPressed: () => Navigator.pushNamed(context, TravellerHome.routeName),
          ),
          GButton(
            icon: Icons.favorite,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            text: 'Favourite',
            onPressed: () => Navigator.pushNamed(context, "#"),
          ),
          GButton(
            icon: Icons.list_alt,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            text: 'Wishlist',
            onPressed: () => Navigator.pushNamed(context, WishList.routeName),
          ),
          GButton(
            icon: Icons.add_circle,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            text: 'Plan',
            onPressed: () => Navigator.pushNamed(context, TravelerCreateTrip.routeName),
          )
        ],
      ),
    );
  }
}

enum Selections { home, favorite, wishlist, add }
