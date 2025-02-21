import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../constants/app_colors.dart';

class CustomAddButton extends StatefulWidget {
  final List<String>? types;
  final LatLng? pos;
  final String? selectedPlace;

  const CustomAddButton(
      {super.key,
      required this.pos,
      required this.types,
      required this.selectedPlace});

  @override
  State<CustomAddButton> createState() => _CustomAddButtonState();
}

class _CustomAddButtonState extends State<CustomAddButton> {
  String? test;
  @override
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed:
          widget.pos == null ? null : () => print("Position ${widget.pos}"),
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
      ),
      child: Icon(
        Icons.add,
        color: AppColors.lightBlueTwo,
        size: 28.0,
      ),
    );
  }
}
