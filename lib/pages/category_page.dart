import 'package:flutter/material.dart';
import 'package:secure_shared_preferences/secure_shared_pref.dart';
import 'package:tour_me/constants.dart';
import 'package:tour_me/widgets/upload_destination_images.dart';

class CategoryPage extends StatelessWidget {
  static const String routeName = '/category';
  const CategoryPage({super.key});

  void _onSelect(BuildContext context, String type) async {
    SecureSharedPref pref = await SecureSharedPref.getInstance();
    pref.putString(MyPrefTags.userType, type, isEncrypted: true);

    if (context.mounted) {
      String? url = await ImageUpload.save(context);
      //TODO:
      // if (type == MyStrings.traveler) Navigator.pushNamed(context, routeName);
      // if (type == MyStrings.merchant) Navigator.pushNamed(context, routeName);
      // if (type == MyStrings.host) Navigator.pushNamed(context, routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Select Category'),
      ),
      body: Column(children: [
        // Traveller
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => _onSelect(context, MyStrings.traveler),
            child: ListTile(
              leading: Image.asset(MyImages.traveler),
              title: const Text(
                'Traveler',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: MyColors.pink,
                ),
              ),
              contentPadding: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
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
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => _onSelect(context, MyStrings.host),
            child: ListTile(
              leading: Image.asset(MyImages.location),
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
                borderRadius: BorderRadius.circular(10),
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
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => _onSelect(context, MyStrings.merchant),
            child: ListTile(
              leading: Image.asset(MyImages.merchant),
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
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(
                  color: MyColors.pink,
                  width: 2.5,
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
