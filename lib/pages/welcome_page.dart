import 'package:flutter/material.dart';
import 'package:tour_me/constants.dart';
import 'package:tour_me/pages/login_page.dart';
import 'package:tour_me/widgets/pink_button.dart';

class WelcomePage extends StatelessWidget {
  static const String routeName = '/welcomePage';
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: double.infinity,
          color: Colors.black,
          child: Center(
            child: SizedBox(
              width: 180,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(MyImages.logo),
                  Image.asset(MyImages.slogan),
                  const SizedBox(height: 25),
                  PinkButton(
                    onPress: () => Navigator.pushReplacementNamed(
                      context,
                      LoginPage.routeName,
                    ),
                    text: 'Get Started',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
