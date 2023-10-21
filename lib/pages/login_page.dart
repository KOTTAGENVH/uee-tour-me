import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:secure_shared_preferences/secure_shared_pref.dart';
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
        // TODO: move to next page
        print('User logged in: ${userCredential.user?.uid}');

        SecureSharedPref pref = await SecureSharedPref.getInstance();
        pref.putString(MyStrings.userId, userCredential.user!.uid, isEncrypted: true);
      } catch (e) {
        String msg = '';

        LoadingPopup().remove();
        if(e is FirebaseAuthException){
          if(e.code == MyErrorCodes.firebaseInvalidLoginCredentials){
            msg = 'Invalid Login Credentials';
          }
        }

        
        if (context.mounted) {
          MessagePopUp.display(
            context,
            message: 'Couldn\'t Log In\n$msg',
          );
        }
        print('Error logging in: $e');
        // Hand
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
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(MyImages.logo
              ,width: 200, 
              height: 200),
              const SizedBox(height: 20),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: const TextStyle(color: Colors.white),
                      prefixIcon: const Icon(
                        Icons.email,
                        color: Colors.white,
                      ),
                      filled: true,
                      fillColor: const Color(0xFF454452),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                  errorText: _emailError,
                  errorBorder: OutlineInputBorder(                 
                      borderRadius: BorderRadius.circular(50.0),
                  ),
                  focusedErrorBorder:OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(50.0),
                  ) 
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: const TextStyle(color: Colors.white),
                      prefixIcon: const Icon(
                        Icons.security,
                        color: Colors.white,
                      ),
                      filled: true,
                      fillColor: const Color(0xFF454452),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                  errorText: _passwordError,
                  errorBorder: OutlineInputBorder(                 
                      borderRadius: BorderRadius.circular(50.0),
                  ),
                  focusedErrorBorder:OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(50.0),
                  ) 
                ),
                style: const TextStyle(color: Colors.white),
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
                    style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
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
