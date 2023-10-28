import 'package:flutter/material.dart';
import 'package:secure_shared_preferences/secure_shared_pref.dart';
import 'package:tour_me/constants.dart';
import 'package:tour_me/pages/destination/destination_home.dart';
import 'package:tour_me/pages/details_page.dart';
import 'package:tour_me/pages/palceholder.dart';
import 'package:tour_me/pages/souvenir/homePage.dart';
import 'package:tour_me/pages/traveller_home.dart';
import 'package:tour_me/utils/upload_user_details.dart';
import 'package:tour_me/widgets/loading_popup.dart';
import 'package:tour_me/widgets/message_popup.dart';

class CategoryPage extends StatelessWidget {
  static const String routeName = '/category';
  const CategoryPage({super.key});

  void _onSelect(BuildContext context, String userRole) async {
    LoadingPopup().display(context, message: 'Please Wait...');

    SecureSharedPref prefs = await SecureSharedPref.getInstance();
    String? id = await prefs.getString(MyPrefTags.userId, isEncrypted: true);

    bool success = false;
    if (userRole == MyStrings.traveler) {
      //TODO: navigate to traveller preferecnes page
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          TouristHome.routeName,
          (route) => false,
        );
      }
    } else if (context.mounted) {
      try {
        await prefs.putString(MyPrefTags.userRole, userRole, isEncrypted: true);
        if (context.mounted) success = await uploadUserDetails(context);
      } catch (e, trace) {
        print("Error: $e");
        print("StackTrace: $trace");
      }
      LoadingPopup().remove();

      if (!success) {
        if (context.mounted) {
          MessagePopUp.display(context);
        } else {
          throw 'error';
        }
      }
    }

    if (success && id != null) {
      if (userRole == MyStrings.host) {
        await prefs.clearAll();
        await prefs.putString(MyPrefTags.userId, id, isEncrypted: true);
        await prefs.putString(MyPrefTags.userRole, userRole, isEncrypted: true);

        if (context.mounted) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            DestinationHome.routeName,
            (route) => false,
          );
        }
      } else if (userRole == MyStrings.merchant) {
        await prefs.clearAll();
        await prefs.putString(MyPrefTags.userId, id, isEncrypted: true);
        await prefs.putString(MyPrefTags.userRole, userRole, isEncrypted: true);

        if (context.mounted) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            SouvenirHomePage.routeName,
            (route) => false,
          );
        }
      } else {
        if (context.mounted) {
          MessagePopUp.display(
            context,
            onDismiss: () {
              prefs.clearAll();
              Navigator.pushNamedAndRemoveUntil(
                context,
                DetailsPage.routeName,
                (route) => false,
              );
            },
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double imageDimensions = MediaQuery.of(context).size.width / 2;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  MyImages.logo,
                  width: imageDimensions,
                  height: imageDimensions,
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Pick Your Category',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              // Traveller
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: GestureDetector(
                  onTap: () => _onSelect(context, MyStrings.traveler),
                  child: ListTile(
                    leading: SizedBox(
                      width: 100,
                      child: Image.asset(MyImages.traveler),
                    ),
                    title: const Text(
                      'Traveler',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: MyColors.pink,
                      ),
                    ),
                    contentPadding: const EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(
                        color: MyColors.pink,
                        width: 2.5,
                      ),
                    ),
                  ),
                ),
              ),
              // Location Host
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: GestureDetector(
                  onTap: () => _onSelect(context, MyStrings.host),
                  child: ListTile(
                    leading: SizedBox(
                      width: 100,
                      child: Image.asset(MyImages.location),
                    ),
                    title: const Text(
                      'Location Hosts',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: MyColors.pink,
                      ),
                    ),
                    contentPadding: const EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(
                        color: MyColors.pink,
                        width: 2.5,
                      ),
                    ),
                  ),
                ),
              ),
              // Merchants
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: GestureDetector(
                  onTap: () => _onSelect(context, MyStrings.merchant),
                  child: ListTile(
                    leading: SizedBox(
                      width: 100,
                      child: Image.asset(MyImages.merchant),
                    ),
                    title: const Text(
                      'Merchants',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: MyColors.pink,
                      ),
                    ),
                    contentPadding: const EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(
                        color: MyColors.pink,
                        width: 2.5,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
