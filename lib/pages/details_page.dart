import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:secure_shared_preferences/secure_shared_pref.dart';
import 'package:tour_me/constants.dart';
import 'package:tour_me/pages/category_page.dart';
import 'package:tour_me/widgets/loading_popup.dart';
import 'package:tour_me/widgets/pink_button.dart';

class DetailsPage extends StatefulWidget {
  static const String routeName = '/details';
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  String? _firstNameError;
  String? _imagePath;

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

  void _getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (context.mounted) LoadingPopup().display(context);
    if (pickedImage == null) {
      LoadingPopup().remove();
      // Image not selected
      return null;
    }

    setState(() {
      _imagePath = pickedImage.path;
    });

    SecureSharedPref prefs = await SecureSharedPref.getInstance();
    prefs.putString(MyPrefTags.profileImage, pickedImage.path);

    LoadingPopup().remove();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('details'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(children: [
                Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.width / 2,
                      width: MediaQuery.of(context).size.width / 2,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: MyColors.pink,
                          width: 5,
                        ),
                      ),
                      child: ClipOval(
                        child: _imagePath == null ? Image.asset(MyImages.profile) : Image.file(File(_imagePath!)),
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      right: 10,
                      child: GestureDetector(
                        onTap: _getImage,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: MyColors.pink,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.black,
                              width: 0.5,
                            ),
                          ),
                          child: const Icon(
                            Icons.camera_enhance_rounded,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
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
      ),
    );
  }
}
