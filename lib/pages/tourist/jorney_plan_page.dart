import 'package:flutter/material.dart';
import 'package:tour_me/constants.dart';
import 'package:tour_me/widgets/bottom_nav.dart';
import 'package:tour_me/widgets/image_card_tourist.dart';
import 'package:tour_me/widgets/one_colunm_table.dart';
import 'package:tour_me/widgets/pink_button.dart';
import 'package:tour_me/widgets/top_nav.dart';

class TouristHome extends StatelessWidget {
  const TouristHome({super.key});
  static const String routeName = '/touristhome';

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: const TopNav(),
    body: Container(
      decoration: const BoxDecoration(gradient: MyColors.backgrounGradient),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
         const Padding(
              padding: EdgeInsets.only(left: 20, bottom:20 , top:5), // Adjust the left padding as needed
              child: Text(
                'Journey Plan',
                style: TextStyle(color: Colors.white, fontSize: 30),
                textAlign: TextAlign.left,
              ),
            ),
           const Padding(
              padding: EdgeInsets.only(left: 20), // Adjust the left padding as needed
              child: Text(
                'Suggestions',
                style: TextStyle(color: Colors.white, fontSize: 16),
                textAlign: TextAlign.left,
              ),
            ),
         const ImageCard(),
       const  Center(child: OneColumnTable(items: ['Item 1', 'Item 2', 'Item 3'])),
          const SizedBox(height: 30),
          Align(
             alignment: Alignment.center,
            child: PinkButton(
            onPress: () => (),
            text: 'Next',
          ),
          )

      

        ],
      ),

    ),
    backgroundColor: Colors.black,
     bottomNavigationBar: const BottomNav(),
  );
}
}