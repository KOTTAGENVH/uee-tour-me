import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tour_me/pages/category_page.dart';
import 'package:tour_me/pages/create_trip_1.dart';
import 'package:tour_me/pages/destination/addDestination.dart';
import 'package:tour_me/pages/destination/destination_home.dart';
import 'package:tour_me/pages/details_page.dart';
import 'package:tour_me/pages/login_page.dart';
import 'package:tour_me/pages/palceholder.dart';
import 'package:tour_me/pages/register_page.dart';
import 'package:tour_me/pages/welcome_page.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'firebase_options.dart';

void main() async {
  Stripe.publishableKey =
      "pk_test_51O3klFGCqmIXB6lwCavfJNjkN4DaZdy33Q3rraNo1vvvOTvYuuIozLoyMWhIlzhOwxh4K4Fnsj86Q8USrvcHlu5T006AKoawWI";
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: const MaterialColor(
          0xFF171717,
          <int, Color>{
            50: Color(0xFFF2F2F2),
            100: Color(0xFFE6E6E6),
            200: Color(0xFFCCCCCC),
            300: Color(0xFFB3B3B3),
            400: Color(0xFF999999),
            500: Color(0xFF808080),
            600: Color(0xFF666666),
            700: Color(0xFF4D4D4D),
            800: Color(0xFF333333),
            900: Color(0xFF1A1A1A),
          },
        ),
      ),
      initialRoute: WelcomePage.routeName,
      routes: {
        WelcomePage.routeName: (context) => const WelcomePage(),
        LoginPage.routeName: (context) => const LoginPage(),
        RegisterPage.routeName: (context) => const RegisterPage(),
        CategoryPage.routeName: (context) => const CategoryPage(),
        DetailsPage.routeName: (context) => const DetailsPage(),
        PlaceholderPage.routeName: (context) => const PlaceholderPage(),
        CreateTrip1.routeName: (context) => const CreateTrip1(),
        DestinationHome.routeName: (context) => const DestinationHome(),
        DestinationAddPage.routeName: (context) => const DestinationAddPage(),
      },
    );
  }
}
