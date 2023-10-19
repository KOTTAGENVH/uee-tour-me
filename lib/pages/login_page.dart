import 'package:flutter/material.dart';
import 'package:tour_me/constants.dart';
import 'package:tour_me/widgets/tablet_text_input.dart';



class LoginPage extends StatelessWidget {
  static const String routeName = '/loginPage';
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                width: MediaQuery.of(context).size.width / 2,
                child: Image.asset(MyImages.logo),
              ),
              const TabletTextField(
                hintText: 'Enter Text',
                keyboardType: TextInputType.emailAddress,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
