import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  final TextEditingController _weekstartTimeController = TextEditingController();
  final TextEditingController _weekendTimeController = TextEditingController();
  final TextEditingController _weekendstartTimeController = TextEditingController();
  final TextEditingController _weekendendTimeController = TextEditingController();
  final TextEditingController _description = TextEditingController();

  final CollectionReference _destination =
      FirebaseFirestore.instance.collection('Destination');

  Future<void> _create() async {
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
    );
  },
);
}
       )
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
},

