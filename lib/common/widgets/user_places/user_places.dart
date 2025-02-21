import 'package:flutter/material.dart';
import 'package:test_app/common/constants/app_colors.dart';

import 'package:test_app/common/controllers/user_places_manager.dart';
import 'package:test_app/common/widgets/user_places/add_new_place_modal.dart';
import 'package:test_app/common/widgets/user_places/user_places_card.dart';

class UserPlaces extends StatefulWidget {
  const UserPlaces({super.key});

  @override
  State<UserPlaces> createState() => _UserPlacesState();
}

//Ao carregar a página, criar busca aos dados.
class _UserPlacesState extends State<UserPlaces> {
  final List<UserPlacesManager> _registeredPlaces = [
    UserPlacesManager(
        description: "Most beautiful place",
        date: DateTime.now(),
        location: "Norway"),
    UserPlacesManager(
        description: "Second most beautiful place",
        date: DateTime.now(),
        location: "Switzerland"),
  ];

  void _addPlaceController() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => AddPlaceModal(
        onAddPlace: _addPlace,
      ),
    );
  }

  void _addPlace(UserPlacesManager newPlace) {
    setState(() {
      _registeredPlaces.add(newPlace);
    });
  }

  void _removePlace(UserPlacesManager place) {
    // Consegue o index do elemento
    final placeIndex = _registeredPlaces.indexOf(place);
    setState(() {
      _registeredPlaces.remove(place);
    });
    // Widget de snackBar
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              // Como sabemos, para alterar a tela do usuário é necessário setState
              setState(() {
                // método insert adiciona um elemento de volta a lista pelo seu índice
                _registeredPlaces.insert(placeIndex, place);
              });
            }),
        content: const Text('Place Removed.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'No places registred yet. Start your journey!',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0),
        ),
      ),
    );

    if (_registeredPlaces.isNotEmpty) {
      mainContent = ListView.builder(
        itemCount: _registeredPlaces.length,
        itemBuilder: (ctx, index) => Dismissible(
          background: Container(
            color: Theme.of(context).colorScheme.error,
            margin: Theme.of(context).cardTheme.margin,
          ),
          direction: DismissDirection.endToStart,
          key: ValueKey(
            _registeredPlaces[index],
          ),
          onDismissed: (direction) {
            _removePlace(_registeredPlaces[index]);
          },
          child: UserPlacesItem(
            placeItem: _registeredPlaces[index],
            index: index,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Travel Places',
          style: TextStyle(
              color: AppColors.lightBlueTwo, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            onPressed: _addPlaceController,
            icon: Icon(
              Icons.add,
              color: AppColors.lightBlueTwo,
              size: 25.0,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: mainContent,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addPlaceController,
        shape: CircleBorder(),
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.primaryContainer,
          size: 30.0,
        ),
      ),
    );
  }
}
