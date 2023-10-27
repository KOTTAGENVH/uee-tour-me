import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tour_me/constants.dart';
import 'package:tour_me/widgets/destination_owner_bottom_nav.dart';
import 'package:tour_me/widgets/labeled_divider.dart';
import 'package:tour_me/widgets/next_back_button.dart';

class UpdateDestination extends StatefulWidget {
  final String destinationName;
  final String streetNo;
  final String streetName;
  final String city;
  final String weekstartTime;
  final String weekendTime;
  final String weekendstartTime;
  final String weekendendTime;
  final String description;
  final String location;
  final String destinationImage1;
  final String destinationImage2;
  final String cardNo;
  final String csv;
  final String expiryDate;
  final String token;
  final String userId;

  const UpdateDestination({
    super.key,
    required this.destinationName,
    required this.streetNo,
    required this.streetName,
    required this.city,
    required this.weekstartTime,
    required this.weekendTime,
    required this.weekendstartTime,
    required this.weekendendTime,
    required this.description,
    required this.location,
    required this.destinationImage1,
    required this.destinationImage2,
    required this.cardNo,
    required this.csv,
    required this.expiryDate,
    required this.token,
    required this.userId, required String documentId,
  });

  @override
  State<UpdateDestination> createState() => _UpdateState();
}

class _UpdateState extends State<UpdateDestination> {
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

 Future<void> _updateDestination() async {
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
                decoration: const InputDecoration(labelText: 'Destination Name'),
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
                decoration: const InputDecoration(labelText: 'Weekend Start Time'),
              ),
              TextField(
                controller: _weekendendTimeController,
                decoration: const InputDecoration(labelText: 'Weekend End Time'),
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
                  final String weekendstartTime = _weekendstartTimeController.text;
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
                      "destinationName": locationName,
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
          title: const Text('Add Destination', style: TextStyle(fontSize: 25)),
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
        child: Column(children: [
          const SizedBox(height: 40),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _locationNameController,
                  decoration: InputDecoration(
                    labelText: 'Destination Name',
                    labelStyle: const TextStyle(color: Colors.white),
                    prefixIcon: const Icon(
                      Icons.add_location_rounded,
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
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 20),
                const LabeledDivider(label: 'Address'),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _streetNoController,
                        decoration: InputDecoration(
                          labelText: 'Street No',
                          labelStyle: const TextStyle(color: Colors.white),
                          prefixIcon: const Icon(
                            Icons.location_on,
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
                          labelStyle: const TextStyle(color: Colors.white),
                          prefixIcon: const Icon(
                            Icons.location_on,
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
                    labelText: 'City & Province',
                    labelStyle: const TextStyle(color: Colors.white),
                    prefixIcon: const Icon(
                      Icons.location_on,
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
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 20),
                const LabeledDivider(label: 'Weekday Time'),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _weekstartTimeController,
                        decoration: InputDecoration(
                          labelText: 'Start Time',
                          labelStyle: const TextStyle(color: Colors.white),
                          prefixIcon: const Icon(
                            Icons.access_time,
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
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: TextFormField(
                        controller: _weekendTimeController,
                        decoration: InputDecoration(
                          labelText: 'End Time',
                          labelStyle: const TextStyle(color: Colors.white),
                          prefixIcon: const Icon(
                            Icons.access_time,
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
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const LabeledDivider(label: 'Weekend Time'),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _weekendstartTimeController,
                        decoration: InputDecoration(
                          labelText: 'Start Time',
                          labelStyle: const TextStyle(color: Colors.white),
                          prefixIcon: const Icon(
                            Icons.access_time,
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
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: TextFormField(
                        controller: _weekendendTimeController,
                        decoration: InputDecoration(
                          labelText: 'End Time',
                          labelStyle: const TextStyle(color: Colors.white),
                          prefixIcon: const Icon(
                            Icons.access_time,
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
                    labelStyle: const TextStyle(color: Colors.white),
                    prefixIcon: const Icon(
                      Icons.description,
                      color: Colors.white,
                    ),
                    filled: true,
                    fillColor: const Color(0xFF454452),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
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
                // NextButton(
                //   onPress: () async {
                //     final String destinationName = _locationNameController.text;
                //     final String streetNo = _streetNoController.text;
                //     final String streetName = _streetNameController.text;
                //     final String city = _cityController.text;
                //     final String weekstartTime = _weekstartTimeController.text;
                //     final String weekendTime = _weekendTimeController.text;
                //     final String weekendstartTime = _weekendstartTimeController.text;
                //     final String weekendendTime = _weekendendTimeController.text;
                //     final String description = _description.text;

                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => DestinationAddPage2(
                //           destinationName: destinationName,
                //           streetNo: streetNo,
                //           streetName: streetName,
                //           city: city,
                //           weekstartTime: weekstartTime,
                //           weekendTime: weekendTime,
                //           weekendstartTime: weekendstartTime,
                //           weekendendTime: weekendendTime,
                //           description: description,
                //         ),
                //       ),
                //     );
                //   },
                //   text: 'Next',
                // ),
              ],
            ),
          ),
        ]),
      ),
      backgroundColor: Colors.black,
      bottomNavigationBar: const DestinationBottomNav(),
    );
  }
}