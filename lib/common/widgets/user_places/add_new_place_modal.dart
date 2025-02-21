import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/common/controllers/user_places_manager.dart';

class AddPlaceModal extends StatefulWidget {
  const AddPlaceModal({super.key, required this.onAddPlace});

  final void Function(UserPlacesManager newPlace) onAddPlace;

  @override
  State<AddPlaceModal> createState() => _AddPlaceModalState();
}

class _AddPlaceModalState extends State<AddPlaceModal> {
  final _placeController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData() {
    if (_selectedDate == null ||
        _placeController.text.trim().isEmpty ||
        _descriptionController.text.trim().isEmpty) {
      if (Platform.isIOS) {
        showDialog(
          context: context,
          builder: (ctx) => CupertinoAlertDialog(
            title: const Text('Invalid Values :('),
            content: const Text(
                'Please make sure that you are providing a value Location and a date.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Okay'),
              ),
            ],
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Invalid Values :('),
            content: const Text(
                'Please make sure that you are providing a value Location and a date.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Okay'),
              ),
            ],
          ),
        );
      }
      return;
    }
    widget.onAddPlace(
      UserPlacesManager(
          description: _descriptionController.text,
          date: _selectedDate!,
          location: _placeController.text),
    );
    Navigator.pop(context);
  }

  void _selectDate() async {
    final initialDate = DateTime.now();
    final firstDate = DateTime(1990);
    final lastDate = DateTime(2101);
    final selectedDate = await showDatePicker(
        context: context,
        firstDate: firstDate,
        initialDate: initialDate,
        lastDate: lastDate);

    setState(() {
      _selectedDate = selectedDate;
    });
  }

  @override
  void dispose() {
    _placeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(
      builder: ((context, constraints) {
        final screenWidth = constraints.maxWidth;

        return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  EdgeInsets.fromLTRB(16.0, 16.0, 16.0, keyboardHeight + 16.0),
              child: Column(
                children: [
                  if (screenWidth >= 600)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _placeController,
                            maxLength: 50,
                            decoration: InputDecoration(
                              label: Text('Location'),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16.0,
                        ),
                        Expanded(
                          child: TextField(
                            controller: _descriptionController,
                            decoration: InputDecoration(
                              label: Text('Description'),
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    TextField(
                      controller: _placeController,
                      maxLength: 50,
                      decoration: InputDecoration(
                        label: Text('Location'),
                      ),
                    ),
                  if (screenWidth >= 600)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              _selectedDate == null
                                  ? 'No date Selected'
                                  : dateFormatter.format(_selectedDate!),
                            ),
                            IconButton(
                              onPressed: _selectDate,
                              icon: Icon(Icons.calendar_month_outlined),
                              iconSize: 26.0,
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Cancel'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _submitData();
                              },
                              child: Text('Save place'),
                            ),
                          ],
                        ),
                      ],
                    )
                  else
                    TextField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        label: Text('Description'),
                      ),
                    ),
                  SizedBox(
                    height: 16.0,
                  ),
                  if (screenWidth >= 600)
                    SizedBox(
                      height: 16.0,
                    )
                  else
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          _selectedDate == null
                              ? 'No date Selected'
                              : dateFormatter.format(_selectedDate!),
                        ),
                        IconButton(
                          onPressed: _selectDate,
                          icon: Icon(Icons.calendar_month_outlined),
                          iconSize: 26.0,
                        )
                      ],
                    ),
                  if (screenWidth >= 600)
                    SizedBox(
                      height: 1.0,
                    )
                  else
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _submitData();
                          },
                          child: Text('Save'),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
