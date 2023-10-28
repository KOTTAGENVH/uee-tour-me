import 'package:flutter/material.dart';
import 'package:tour_me/widgets/bottom_nav.dart';
import 'package:tour_me/widgets/top_nav.dart';

class DetailDestinationPage extends StatelessWidget {
  const DetailDestinationPage({Key? key}) : super(key: key);
static const String routeName = '/detailDestination';
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNav(),
      body: Center(
        child: Container(
          color: Colors.black,
          child: Column(
            children: [
              
              Image.asset(
                'assets/images/img1.jpg', // Replace with your actual asset path
                width: 300 ,
                height: 300,
              ),
              const SizedBox(height: 40),
              Expanded(child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration:const  BoxDecoration(
                  color: Colors.grey ,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
              child: const Column(
                children : [
              Expanded(
                child:Column(
                  children: [
                    Text(
                      'Location Name ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Description ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                    ),
                    Text(
                      'Location Name ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  SizedBox(height: 30),
                   Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // PinkButton(
                  //   onPress: () {},
                  //   text: 'Next',
                  // ),
                  // PinkButton(
                  //   onPress: () {},
                  //   text: 'Skip',
                  // ),
                ],
              ),
            ],
                )
               )
        
              ]
              ),
              ))
            ],
          ),
        ),
      ),
      backgroundColor: Colors.black,
    bottomNavigationBar: const BottomNav(),
    );

  }
}
