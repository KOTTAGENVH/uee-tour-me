import 'package:flutter/material.dart';
import 'package:tour_me/constants.dart';
import 'package:tour_me/widgets/bottom_nav.dart';
import 'package:tour_me/widgets/card/image_card_list.dart';
import 'package:tour_me/widgets/top_nav.dart';

class Favourites
 extends StatelessWidget {
  const Favourites
  ({super.key});
static const String routeName = '/favourites';

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       appBar: const TopNav(),
       body: Container(
       decoration: const BoxDecoration(gradient: MyColors.backgrounGradient),
       child:
        Column(
          children: [
             
         const Padding(
              padding: EdgeInsets.only(left: 20, bottom:20 , top:5), // Adjust the left padding as needed
              child: Text(
                'Favorites',
                style: TextStyle(color: Colors.white, fontSize: 30),
                textAlign: TextAlign.left,
              ),
            ),
            ImageCardList(),
          ],
        ),
    ),
    backgroundColor: Colors.black,
    bottomNavigationBar: const BottomNav(),
    );

  }
}