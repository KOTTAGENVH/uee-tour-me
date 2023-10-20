import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tour_me/constants.dart';
import 'package:tour_me/pages/register_page.dart';
import 'package:tour_me/widgets/labeled_divider.dart';
import 'package:tour_me/widgets/loading_popup.dart';
import 'package:tour_me/widgets/message_popup.dart';
import 'package:tour_me/widgets/pink_button.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login';

  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _emailError;
  String? _passwordError;

  void _login() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    setState(() {
      _emailError = _validateEmail(email);
      _passwordError = _validatePassword(password);
    });

    if (_emailError == null && _passwordError == null) {
      LoadingPopup().display(context, message: 'Logging');
      try {
        final UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        LoadingPopup().remove();

        if(context.mounted) MessagePopUp.display(context, );

        // Login successful, you can access the user information with userCredential.user
        print('User logged in: ${userCredential.user?.uid}');
      } catch (e) {
        LoadingPopup().remove();
        print('Error logging in: $e');
        // Handle login errors here
      }
    }
  }

  String? _validateEmail(String email) {
    if (email.isEmpty) {
      return 'Email is required';
    } else if (!MyRegExps.email.hasMatch(email)) {
      return 'Invalid email format';
    }
    return null;
  }

  String? _validatePassword(String password) {
    if (password.isEmpty) {
      return 'Password is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  errorText: _emailError,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  errorText: _passwordError,
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              PinkButton(
                onPress: _login,
                text: 'Login',
              ),
              const SizedBox(height: 20),
              const LabeledDivider(label: 'OR'),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => Navigator.pushReplacementNamed(context, RegisterPage.routeName),
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(color: Colors.black),
                    text: 'Don\'t have an account yet?  ',
                    children: <TextSpan>[
                      TextSpan(
                        text: '  Register',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: MyColors.pink,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
