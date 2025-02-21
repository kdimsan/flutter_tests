import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:test_app/common/constants/app_colors.dart';
import 'package:test_app/common/controllers/user_places_manager.dart';

class UserPlacesItem extends StatelessWidget {
  const UserPlacesItem(
      {super.key, required this.placeItem, required this.index});

  final UserPlacesManager placeItem;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
          child: Column(
            children: [
              Text(
                placeItem.location,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(
                height: 4.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(placeItem.description,
                        style: Theme.of(context).textTheme.bodySmall),
                  ),
                  SizedBox(
                    width: 14.0,
                  ),
                  Row(
                    children: [
                      Icon(Icons.flight_takeoff_sharp),
                      SizedBox(width: 8.0),
                      Text(
                        placeItem.formattedDate,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              )
            ],
          )),
    );
  }
}
