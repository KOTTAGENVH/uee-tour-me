// ignore_for_file: use_build_context_synchronously

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tour_me/constants.dart';
import 'package:tour_me/widgets/destination_owner_bottom_nav.dart';
import 'package:tour_me/widgets/next_back_button.dart';

class ViewOneDestination extends StatefulWidget {
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
  final String documentId;

  const ViewOneDestination({
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
    required this.userId,
    required this.documentId,
  });

  @override
  State<ViewOneDestination> createState() => _ViewOneDestinationState();
}

class _ViewOneDestinationState extends State<ViewOneDestination> {
  final CollectionReference _calculatedpeakhours =
      FirebaseFirestore.instance.collection('CalculatedPeakHours');
      
        get destinationId => null;

    Future<void> _getNextButtonAction(BuildContext context) async {
    try {
      final peakHoursSnapshot = await _calculatedpeakhours
          .where('documentId', isEqualTo: destinationId)
          .get();

      if (peakHoursSnapshot.docs.isNotEmpty) {
        final peakHoursData = peakHoursSnapshot.docs.first.data();

final Map<String, dynamic>? peakData = peakHoursData as Map<String, dynamic>?;

final day = peakData?['day'] as String?;
final startTime = peakData?['startTime'] as String?;
final endTime = peakData?['endTime'] as String?;

        // Display the peak hours in a dialog or popup
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
      title: Text('Calculated Peak Hours'),
      content: SizedBox(
        height: 200, // Set your desired height
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('Day: ${day ?? "Not Available"}'),
              Text('Start Time: ${startTime ?? "Not Available"}'),
              Text('End Time: ${endTime ?? "Not Available"}'),
            ],
          ),
           ),
      ),
            );
          },
        );
      } else {
        // Display a message for no peak hours available
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('No Peak Hours Available'),
              content: Text('Peak hours information is not found for this destination.'),
            );
          },
        );
      }
    } catch (error) {
      print('Error: $error');
      // Handle errors, e.g., show an error message or retry mechanism
    }
  }

  void _onPressCallback() {
    _getNextButtonAction(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: AppBar(
          leading: Image.asset(MyImages.iconLogo),
          title: const Text('', style: TextStyle(fontSize: 25)),
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
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: CarouselSlider(
                options: CarouselOptions(
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.9,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                ),
                items: [
                  // Displaying the images using the provided URLs
                  Image.network(widget.destinationImage1, fit: BoxFit.cover),
                  Image.network(widget.destinationImage2, fit: BoxFit.cover),
                  Image.network(
                    widget.destinationImage1,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: 200, // Adjust the height as needed
                  ),
                  Image.network(
                    widget.destinationImage2,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 40, 20, 20),
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.pink), // Border styling
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Destination Name: ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: '${widget.destinationName}',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Address: ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text:
                              '${widget.streetNo}, ${widget.streetName}, ${widget.city}',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Working Hours: \n',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text:
                              'WeekDay: ${widget.weekstartTime} - ${widget.weekendTime}\n',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        TextSpan(
                          text:
                              'WeekEnd: ${widget.weekendstartTime} - ${widget.weekendendTime}',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Description: ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: '${widget.description}',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Destination Token: ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: '${widget.token}',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  NextButton(
                  onPress: _onPressCallback,
                    text: 'View Peak Hours',
                    icon: const Icon(Icons.arrow_forward_ios),
                  ),
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
