import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:secure_shared_preferences/secure_shared_preferences.dart';
import 'package:tour_me/constants.dart';
import 'package:tour_me/pages/category_page.dart';
import 'package:tour_me/pages/login_page.dart';
import 'package:tour_me/widgets/labeled_divider.dart';
import 'package:tour_me/widgets/loading_popup.dart';
import 'package:tour_me/widgets/message_popup.dart';
import 'package:tour_me/widgets/pink_button.dart';

class RegisterPage extends StatefulWidget {
  static const routeName = '/register';

  const RegisterPage({Key? key}) : super(key: key);

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;

  void _register() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    // Validation logic
    setState(() {
      _emailError = _validateEmail(email);
      _passwordError = _validatePassword(password);
      _confirmPasswordError = _validateConfirmPassword(password, confirmPassword);
    });

    if (_emailError == null && _passwordError == null && _confirmPasswordError == null) {
      try {
        LoadingPopup().display(context, message: 'Creating Account');
        final UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        LoadingPopup().remove();

        // Registration successful, you can access the user information with userCredential.user
        String? uid = userCredential.user?.uid;
        if (uid == null) {
          throw 'Couldn\'t get User Id';
        }
        print('User registered: $uid');

        if (context.mounted) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            CategoryPage.routeName,
            (route) => false,
          );
        }else{
          throw 'context error';
        }

        SecureSharedPref pref = await SecureSharedPref.getInstance();
        pref.putString(MyStrings.userId, uid, isEncrypted: true);
      } catch (e) {
        LoadingPopup().remove();
        print('Error registering user: $e');

        if (context.mounted) {
          MessagePopUp.display(
            context,
            message: "Couldn't create Account!\n$e",
          );
        }
      }
    }
  }

  String? _validateEmail(String email) {
    // Add your email validation logic here
    if (email.isEmpty) {
      return 'Email is required';
    } else if (!MyRegExps.email.hasMatch(email)) {
      return 'Invalid email format';
    }
    return null;
  }

  String? _validatePassword(String password) {
    // Add your password validation logic here
    if (password.isEmpty) {
      return 'Password is required';
    } else if (password.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? _validateConfirmPassword(String password, String confirmPassword) {
    // Add your confirm password validation logic here
    if (confirmPassword.isEmpty) {
      return 'Confirm Password is required';
    } else if (password != confirmPassword) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.black,
     appBar: AppBar(
      automaticallyImplyLeading: false,
       centerTitle: true,
       backgroundColor:Colors.black,         
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
              TextField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
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
                  errorText: _confirmPasswordError,
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
                onPress: _register,
                text: "Register",
              ),
              const SizedBox(height: 20),
              const LabeledDivider(label: 'OR'),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => Navigator.pushReplacementNamed(context, LoginPage.routeName),
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                    text: 'Already Signed In?  ',
                    children: <TextSpan>[
                      TextSpan(
                        text: '  Login',
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
