// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:secure_shared_preferences/secure_shared_pref.dart';
import 'package:tour_me/constants.dart';
import 'package:tour_me/pages/destination/suggestiontime/tokenvalidation.dart';
import 'package:tour_me/widgets/destination_owner_bottom_nav.dart';
import 'package:tour_me/widgets/labeled_divider.dart';
import 'package:tour_me/widgets/next_back_button.dart';

class AddDestinationPeak extends StatefulWidget {
  final String destinationid;
  final String destinationName;
  final String city;
  final String destinationImage1;
  final String destinationImage2;
  final String token;
  final String userId;

  const AddDestinationPeak(
      {super.key,
      required this.destinationid,
      required this.destinationName,
      required this.city,
      required this.destinationImage1,
      required this.destinationImage2,
      required this.token,
      required this.userId});

  @override
  State<AddDestinationPeak> createState() => _AddDestinationPeakState();
}

class _AddDestinationPeakState extends State<AddDestinationPeak> {
  final TextEditingController _startTime = TextEditingController();
  final TextEditingController _endTime = TextEditingController();
  final TextEditingController _day = TextEditingController();

  final CollectionReference _suggestedpeakhours =
      FirebaseFirestore.instance.collection('SuggestedPeakHours');
  final CollectionReference _calculatedpeakhours =
      FirebaseFirestore.instance.collection('CalculatedPeakHours');

  @override
  Widget build(BuildContext context) {
    String selectedDay = 'Monday';
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: AppBar(
          leading: Image.asset(MyImages.iconLogo),
          title:
              const Text('Suggest Peak Hours', style: TextStyle(fontSize: 25)),
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
            // const SizedBox(height: 40),
            Container(
              margin: EdgeInsets.only(bottom: 20, top: 5),
              child: Text(
                widget.destinationName != null
                    ? widget.destinationName
                    : 'Error occurred',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 4, left: 25, right: 20),
              width: 360, // Adjust width as needed
              height: 220, // Adjust height as needed
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(20), // Adjust the border radius
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                    40), // Same border radius as the container
                child: widget.destinationImage1 != null
                    ? Image.network(
                        widget
                            .destinationImage1, // Use widget.destinationImage1 if not null
                        fit: BoxFit
                            .cover, // You can use a different BoxFit to control image scaling
                      )
                    : Container(
                        color:
                            Colors.grey, // Placeholder color if image is null
                        child: Center(
                          child: Text(
                            'Image not available',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20, top: 20),
              child: Text(
                widget.city != null ? widget.city : 'Error occurred',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ),
            Container(
              margin:
                  EdgeInsets.only(bottom: 20), // Adjust the margin as needed
              child: const LabeledDivider(label: 'Peak hour suggestion'),
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _startTime,
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
                Text(
                  'TO',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextFormField(
                    controller: _endTime,
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
            Container(
              margin: EdgeInsets.only(
                  bottom: 20, top: 20), // Adjust the margin as needed
              child: const LabeledDivider(label: 'Peak day suggestion'),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedDay,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedDay = newValue;
                  });
                }
              },
              items: <String>[
                'Monday',
                'Tuesday',
                'Wednesday',
                'Thursday',
                'Friday',
                'Saturday',
                'Sunday'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Select a day',
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
              style: const TextStyle(color: Colors.black),
            ),
            Container(
              margin: const EdgeInsets.only(top: 40), // Add top margin here
              child: NextButton(
                onPress: () async {
                  final String startTime = _startTime.text;
                  final String endTime = _endTime.text;
                  final String day = selectedDay;
                  final String destinationid = widget.destinationid;
                  final String destinationToken = widget.token;
                  final String date = DateTime.now().toString();

                  if (startTime.isNotEmpty &&
                      endTime.isNotEmpty &&
                      day.isNotEmpty &&
                      destinationid.isNotEmpty &&
                      destinationToken.isNotEmpty &&
                      date.isNotEmpty) {
                    // Add the peak hours to the SuggestedPeakHours collection
                    await _suggestedpeakhours.add({
                      'startTime': startTime,
                      'endTime': endTime,
                      'day': day,
                      'destinationid': destinationid,
                      'destinationToken': destinationToken,
                      'date': date,
                    }).then((value) async {
                      // Retrieve the data from the SuggestedPeakHours collection
                      final snapshot = await FirebaseFirestore.instance
                          .collection('SuggestedPeakHours')
                          .get();

                      // Count the number of documents retrieved
                      final numberOfDocuments = snapshot.size;
                      print(
                          'Number of documents retrieved: $numberOfDocuments');

                      if (snapshot.docs.isNotEmpty) {
                        for (var doc in snapshot.docs) {
                          print('Suggested Peak Hours: ${doc.data()}');
                          // You can do more with the retrieved data here
                        }
                      }

                      if (numberOfDocuments == 1) {
                        await _calculatedpeakhours
                            .where('destinationid', isEqualTo: destinationid)
                            .get()
                            .then((snapshot) async {
                              
                          for (var doc in snapshot.docs) {
                            doc.reference.delete();
                          }
                     

                        // Add the peak hours to the CalculatedPeakHours collection
                        await _calculatedpeakhours.add({
                          'startTime': startTime,
                          'endTime': endTime,
                          'day': day,
                          'destinationid': destinationid,
                          'destinationToken': destinationToken,
                          'date': date,
                        });
                           });
                      } else if (numberOfDocuments == 2) {
                        await _calculatedpeakhours
                            .where('destinationid', isEqualTo: destinationid)
                            .get()
                            .then((snapshot) {
                          for (var doc in snapshot.docs) {
                            doc.reference.delete();
                          }
                        });

                        // Check and compare the dates for the latest entry if there are two documents
                        final sortedDocs = snapshot.docs
                          ..sort((a, b) =>
                              b.data()['date'].compareTo(a.data()['date']));

                        final latestDocDate = sortedDocs.first.data()['date'];

                        // Select the latest entry based on the date
                        for (var doc in snapshot.docs) {
                          if (doc.data()['date'] == latestDocDate) {
                            await _calculatedpeakhours.add({
                              'startTime': doc.data()['startTime'],
                              'endTime': doc.data()['endTime'],
                              'day': doc.data()['day'],
                              'destinationid': doc.data()['destinationid'],
                              'destinationToken':
                                  doc.data()['destinationToken'],
                              'date': doc.data()['date'],
                            });
                            break; // Exit loop after adding the latest entry
                          }
                        }
                      } else if (numberOfDocuments > 2) {
                        await _calculatedpeakhours
                            .where('destinationid', isEqualTo: destinationid)
                            .get()
                            .then((snapshot) {
                          for (var doc in snapshot.docs) {
                            doc.reference.delete();
                          }
                        });

                        final random = Random();
                        final randomIndex = random.nextInt(numberOfDocuments);

                        await _calculatedpeakhours.add({
                          'startTime':
                              snapshot.docs[randomIndex].data()['startTime'],
                          'endTime':
                              snapshot.docs[randomIndex].data()['endTime'],
                          'day': snapshot.docs[randomIndex].data()['day'],
                          'destinationid': snapshot.docs[randomIndex]
                              .data()['destinationid'],
                          'destinationToken': snapshot.docs[randomIndex]
                              .data()['destinationToken'],
                          'date': snapshot.docs[randomIndex].data()['date'],
                        });
                      }else{
                          // Add the peak hours to the CalculatedPeakHours collection
                        await _calculatedpeakhours.add({
                          'startTime': startTime,
                          'endTime': endTime,
                          'day': day,
                          'destinationid': destinationid,
                          'destinationToken': destinationToken,
                          'date': date,
                        });
                      }
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please fill in all fields'),
                      ),
                    );
                  }
                },
                text: 'Confirm',
                icon: const Icon(Icons.arrow_forward_ios),
              ),
            )
          ],
        ),
      ),
      backgroundColor: Colors.black,
      bottomNavigationBar: const DestinationBottomNav(),
    );
  }
}
