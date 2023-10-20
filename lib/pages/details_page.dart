import 'package:flutter/material.dart';
import 'package:secure_shared_preferences/secure_shared_pref.dart';
import 'package:tour_me/constants.dart';
import 'package:tour_me/pages/category_page.dart';
import 'package:tour_me/widgets/pink_button.dart';

class DetailsPage extends StatefulWidget {
  static const String routeName = '/details';
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  String? _firstNameError;

  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();

  void _onSubmit(BuildContext context) async {
    if (_firstName.text.trim().isEmpty) {
      setState(() {
        _firstNameError = "First name is required";
      });
      return;
    }

    SecureSharedPref prefs = await SecureSharedPref.getInstance();
    prefs.putString(MyPrefTags.firstName, _firstName.text.trim());
    prefs.putString(MyPrefTags.lastName, _lastName.text.trim());

    if (context.mounted) Navigator.pushNamed(context, CategoryPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('details'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(children: [
              TextField(
                controller: _firstName,
                decoration: InputDecoration(
                  labelText: 'First Name',
                  errorText: _firstNameError,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _lastName,
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                ),
              ),
              const SizedBox(height: 20),
              PinkButton(
                onPress: () => _onSubmit(context),
                text: 'Next',
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
