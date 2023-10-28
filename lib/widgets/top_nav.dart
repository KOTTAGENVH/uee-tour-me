import 'package:flutter/material.dart';
import 'package:tour_me/constants.dart';

class TopNav extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(56);
  const TopNav({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Image.asset(MyImages.iconLogo),
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: CircleAvatar(
            backgroundImage: NetworkImage("https://i1.sndcdn.com/artworks-000076772850-gfnyiy-t240x240.jpg"),
            radius: 20,
          ),
        ),
      ],
      backgroundColor: Colors.black,
      elevation: 16,
    );
  }
}
