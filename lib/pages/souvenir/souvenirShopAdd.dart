import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SouvenirAddPage extends StatefulWidget {
  const SouvenirAddPage({super.key});

  @override
  State<SouvenirAddPage> createState() => _SouvenirAddPageState();
}

class _SouvenirAddPageState extends State<SouvenirAddPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final CollectionReference _souvenir =
      FirebaseFirestore.instance.collection('Souvenir');

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
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: _addressController,
                  decoration: const InputDecoration(labelText: 'Address'),
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Create'),
                  onPressed: () async {
                    final String name = _nameController.text;
                    final String address = _addressController.text;
                    final String description = _addressController.text;
                    if (name.isNotEmpty &&
                        address.isNotEmpty &&
                        description.isNotEmpty) {
                      await _souvenir.add({
                        "shopName": name,
                        "address": address,
                        "description": description
                      });

                      _nameController.text = '';
                      _addressController.text = '';
                      _descriptionController.text = '';
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
