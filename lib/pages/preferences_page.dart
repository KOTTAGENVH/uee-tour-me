import 'package:flutter/material.dart';
import 'package:tour_me/constants.dart';
import 'package:tour_me/pages/traveller_home.dart';
import 'package:tour_me/widgets/pink_button.dart';
import 'package:tour_me/widgets/top_nav.dart';

class PreferencesPage extends StatefulWidget {
  static const String routeName = '/preferences';
  const PreferencesPage({Key? key}) : super(key: key);

  @override
  State<PreferencesPage> createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  static const List<String> names = [
    'Hiking',
    'Surfing',
    'Swim',
    'Ruins',
    'Shopping',
    'Beach',
    'Dayout',
    'Forests',
    'Adventure',
    'Hotels',
    'Religious Places',
    'Camping',
    'Theme Parks',
    'Hillside'
  ];
  List<bool> isSelected = List.generate(14, (index) => false);

  void toggleSelect(int index) {
    setState(() {
      isSelected[index] = !isSelected[index];
    });
  }

  void goNext(){
    Navigator.pushReplacementNamed(context, TravellerHome.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopNav(),
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(gradient: MyColors.backgrounGradient),
        child: Column(children: <Widget>[
          const Text(
            'What are you interested in?',
            style: TextStyle(
              fontSize: 27,
              color: Colors.white,
            ),
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Divider(
              thickness: 2,
              color: Colors.pink,
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(7.0),
            child: Wrap(
              alignment: WrapAlignment.spaceEvenly,
              spacing: 10.0,
              runSpacing: 14.0,
              children: List.generate(names.length, (index) {
                return Container(
                  constraints: const BoxConstraints(minWidth: 80, minHeight: 40),
                  child: GestureDetector(
                    onTap: () {
                      toggleSelect(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected[index] ? Colors.pink : Colors.black,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.pink),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          names[index],
                          style: TextStyle(color: isSelected[index] ? Colors.white : Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Divider(
              thickness: 2,
              color: Colors.pink,
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              PinkButton(
                onPress: goNext,
                text: 'Skip',
              ),
              PinkButton(
                onPress: goNext,
                text: 'Next',
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
