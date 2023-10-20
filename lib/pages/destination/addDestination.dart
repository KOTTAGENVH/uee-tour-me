import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tour_me/constants.dart';
import 'package:tour_me/widgets/bottom_nav.dart';
import 'package:tour_me/widgets/destination_owner_bottom_nav.dart';
import 'package:tour_me/widgets/pink_button.dart';

class DestinationAddPage extends StatefulWidget {
  const DestinationAddPage({super.key});

  @override
  State<DestinationAddPage> createState() => _DestinationAddPageState();
}

// ignore: camel_case_types
class _DestinationAddPageState extends State<DestinationAddPage> {
  final TextEditingController _locationNameController = TextEditingController();
  final TextEditingController _streetNoController = TextEditingController();
  final TextEditingController _streetNameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _weekstartTimeController =
      TextEditingController();
  final TextEditingController _weekendTimeController = TextEditingController();
  final TextEditingController _weekendstartTimeController =
      TextEditingController();
  final TextEditingController _weekendendTimeController =
      TextEditingController();
  final TextEditingController _description = TextEditingController();

  final CollectionReference _destination =
      FirebaseFirestore.instance.collection('Destination');

  // ignore: unused_element
  Future<void> _createDestination() async {
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext ctx) {
        return Padding(
          padding: EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _locationNameController,
                decoration: const InputDecoration(labelText: 'Location Name'),
              ),
              TextField(
                controller: _streetNoController,
                decoration: const InputDecoration(labelText: 'Street No'),
              ),
              TextField(
                controller: _streetNameController,
                decoration: const InputDecoration(labelText: 'Street Name'),
              ),
              TextField(
                controller: _cityController,
                decoration: const InputDecoration(labelText: 'City'),
              ),
              TextField(
                controller: _weekstartTimeController,
                decoration: const InputDecoration(labelText: 'Week Start Time'),
              ),
              TextField(
                controller: _weekendTimeController,
                decoration: const InputDecoration(labelText: 'Week End Time'),
              ),
              TextField(
                controller: _weekendstartTimeController,
                decoration:
                    const InputDecoration(labelText: 'Weekend Start Time'),
              ),
              TextField(
                controller: _weekendendTimeController,
                decoration:
                    const InputDecoration(labelText: 'Weekend End Time'),
              ),
              TextField(
                controller: _description,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: const Text('Create'),
                onPressed: () async {
                  final String locationName = _locationNameController.text;
                  final String streetNo = _streetNoController.text;
                  final String streetName = _streetNameController.text;
                  final String city = _cityController.text;
                  final String weekstartTime = _weekstartTimeController.text;
                  final String weekendTime = _weekendTimeController.text;
                  final String weekendstartTime =
                      _weekendstartTimeController.text;
                  final String weekendendTime = _weekendendTimeController.text;
                  final String description = _description.text;
                  if (locationName.isNotEmpty &&
                      streetNo.isNotEmpty &&
                      streetName.isNotEmpty &&
                      city.isNotEmpty &&
                      weekstartTime.isNotEmpty &&
                      weekendTime.isNotEmpty &&
                      weekendstartTime.isNotEmpty &&
                      weekendendTime.isNotEmpty &&
                      description.isNotEmpty) {
                    await _destination.add({
                      "locationName": locationName,
                      "streetNo": streetNo,
                      "streetName": streetName,
                      "city": city,
                      "weekstartTime": weekstartTime,
                      "weekendTime": weekendTime,
                      "weekendstartTime": weekendstartTime,
                      "weekendendTime": weekendendTime,
                      "description": description,
                    });

                    _locationNameController.text = '';
                    _streetNoController.text = '';
                    _streetNameController.text = '';
                    _cityController.text = '';
                    _weekstartTimeController.text = '';
                    _weekendTimeController.text = '';
                    _weekendstartTimeController.text = '';
                    _weekendendTimeController.text = '';
                    _description.text = '';
                    Navigator.of(context).pop();
                  }
                },
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: AppBar(
          leading: Image.asset(MyImages.iconLogo),
          title: const Text('Form', style: TextStyle(fontSize: 25)),
          centerTitle: true,
          backgroundColor: Colors.black,
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white.withOpacity(0.5),
              ),
            )
          ],
        ),
      ),
     body: SingleChildScrollView(
  child: Column(
    children: [
      const SizedBox(height: 40),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            TextFormField(
              controller: _locationNameController,
              decoration: InputDecoration(
                labelText: 'Location Name',
                labelStyle: TextStyle(color: Colors.white),
                prefixIcon: Icon(
                  Icons.location_on,
                  color: Colors.white,
                ),
                filled: true,
                fillColor: Color(0xFF454452),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(50.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _streetNoController,
                    decoration: InputDecoration(
                      labelText: 'Street No',
                      labelStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(
                        Icons.location_on,
                        color: Colors.white,
                      ),
                      filled: true,
                      fillColor: Color(0xFF454452),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextFormField(
                    controller: _streetNameController,
                    decoration: InputDecoration(
                      labelText: 'Street Name',
                      labelStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(
                        Icons.location_on,
                        color: Colors.white,
                      ),
                      filled: true,
                      fillColor: Color(0xFF454452),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
                  TextFormField(
                    controller: _cityController,
                    decoration: InputDecoration(
                      labelText: 'City',
                      labelStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(
                        Icons.location_on,
                        color: Colors.white,
                      ),
                      filled: true,
                      fillColor: Color(0xFF454452),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _weekstartTimeController,
                    decoration: InputDecoration(
                      labelText: 'Week Start Time',
                      labelStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(
                        Icons.location_on,
                        color: Colors.white,
                      ),
                      filled: true,
                      fillColor: Color(0xFF454452),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextFormField(
                    controller: _weekendTimeController,
                    decoration: InputDecoration(
                      labelText: 'Week End Time',
                      labelStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(
                        Icons.location_on,
                        color: Colors.white,
                      ),
                      filled: true,
                      fillColor: Color(0xFF454452),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            
                 Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _weekendstartTimeController,
                    decoration: InputDecoration(
                      labelText: 'Weekend Start Time',
                      labelStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(
                        Icons.location_on,
                        color: Colors.white,
                      ),
                      filled: true,
                      fillColor: Color(0xFF454452),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextFormField(
                    controller: _weekendendTimeController,
                    decoration: InputDecoration(
                      labelText: 'Weekend End Time',
                      labelStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(
                        Icons.location_on,
                        color: Colors.white,
                      ),
                      filled: true,
                      fillColor: Color(0xFF454452),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            
          const SizedBox(height: 20),
                  TextFormField(
                    controller: _description,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      labelStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(
                        Icons.description,
                        color: Colors.white,
                      ),
                      filled: true,
                      fillColor: Color(0xFF454452),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                    maxLines: 4,
                  ),
                  const SizedBox(height: 30),
                  PinkButton(
                    onPress: () async {
                      final String locationName = _locationNameController.text;
                      final String streetNo = _streetNoController.text;
                      final String streetName = _streetNameController.text;
                      final String city = _cityController.text;
                      final String weekstartTime =
                          _weekstartTimeController.text;
                      final String weekendTime = _weekendTimeController.text;
                      final String weekendstartTime =
                          _weekendstartTimeController.text;
                      final String weekendendTime =
                          _weekendendTimeController.text;
                      final String description = _description.text;
                      if (locationName.isNotEmpty &&
                          streetNo.isNotEmpty &&
                          streetName.isNotEmpty &&
                          city.isNotEmpty &&
                          weekstartTime.isNotEmpty &&
                          weekendTime.isNotEmpty &&
                          weekendstartTime.isNotEmpty &&
                          weekendendTime.isNotEmpty &&
                          description.isNotEmpty) {
                        await _destination.add({
                          "locationName": locationName,
                          "streetNo": streetNo,
                          "streetName": streetName,
                          "city": city,
                          "weekstartTime": weekstartTime,
                          "weekendTime": weekendTime,
                          "weekendstartTime": weekendstartTime,
                          "weekendendTime": weekendendTime,
                          "description": description,
                        });

                        _locationNameController.text = '';
                        _streetNoController.text = '';
                        _streetNameController.text = '';
                        _cityController.text = '';
                        _weekstartTimeController.text = '';
                        _weekendTimeController.text = '';
                        _weekendstartTimeController.text = '';
                        _weekendendTimeController.text = '';
                        _description.text = '';
                        // Navigator.of(context).pop();
                      }
                    },
                    text: 'Add Create',
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
      bottomNavigationBar: const DestinationBottomNav(),
    );
  }
}
