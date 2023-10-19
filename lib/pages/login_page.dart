import 'package:flutter/material.dart';
import 'package:tour_me/constants.dart';
import 'package:tour_me/widgets/pink_button.dart';
import 'package:tour_me/widgets/tablet_text_input.dart';

class LoginPage extends StatelessWidget {
  static const String routeName = '/loginPage';

  LoginPage({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    width: MediaQuery.of(context).size.width / 2,
                    child: Image.asset(MyImages.logo),
                  ),
                  TabletTextField(
                    hintText: 'Enter Email',
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                      if (!value.contains('@')) {
                        return 'Invalid email format';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TabletTextField(
                    hintText: 'Enter Password',
                    keyboardType: TextInputType.visiblePassword,
                    controller: _passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TabletTextField(
                    hintText: 'Enter Confirm Password',
                    keyboardType: TextInputType.visiblePassword,
                    controller: _confirmPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Confirm Password is required';
                      }
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 60),
                  PinkButton(
                    onPress: () {
                      if (_formKey.currentState!.validate()) {
                        print('sfd');
                      }
                    },
                    text: 'Create Account',
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
