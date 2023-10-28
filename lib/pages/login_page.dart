import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:secure_shared_preferences/secure_shared_pref.dart';
import 'package:tour_me/constants.dart';
import 'package:tour_me/models/app_user.dart';
import 'package:tour_me/pages/destination/destination_home.dart';
import 'package:tour_me/pages/register_page.dart';
import 'package:tour_me/pages/souvenir/homePage.dart';
import 'package:tour_me/pages/traveller_home.dart';
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
        // Log In with firestore
        final UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        String uid = userCredential.user!.uid;

        //Get User Role from Firestore
        String? userRole;
        final FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
        DocumentReference documentReference = firestoreInstance.collection(MyFirestore.usersCollection).doc(uid);
        await documentReference.get().then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {
            Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
            userRole = data[AppUser.USER_ROLE];
          }
        });

        //Store id and role in prefs
        if (userRole != null) {
          SecureSharedPref prefs = await SecureSharedPref.getInstance();
          await prefs.clearAll();
          await prefs.putString(MyPrefTags.userId, uid, isEncrypted: true);
          await prefs.putString(MyPrefTags.userRole, userRole!, isEncrypted: true);
        } else {
          throw 'userRole is null';
        }

        LoadingPopup().remove();

        String nextPageRoute = '';

        //Navigate to respective dashboards
        if (userRole == MyStrings.host) {
          nextPageRoute = DestinationHome.routeName;
        } else if (userRole == MyStrings.merchant) {
          nextPageRoute = SouvenirHomePage.routeName;
        } else if (userRole == MyStrings.traveler) {
          nextPageRoute = TravellerHome.routeName;
        }

        if (context.mounted) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            nextPageRoute,
            (route) => false,
          );
        }
      } catch (e) {
        String msg = e.toString();

        LoadingPopup().remove();
        if (e is FirebaseAuthException) {
          if (e.code == MyErrorCodes.firebaseInvalidLoginCredentials) {
            msg = 'Invalid Login Credentials';
          }
        }

        if (context.mounted) {
          MessagePopUp.display(
            context,
            message: 'Couldn\'t Log In\n$msg',
          );
        }
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
    double imageDimensions = MediaQuery.of(context).size.width / 2 + 30;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                MyImages.logo,
                width: imageDimensions,
                height: imageDimensions,
              ),
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
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
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
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
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
