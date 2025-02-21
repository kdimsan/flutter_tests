import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:test_app/common/constants/app_colors.dart';
import 'package:test_app/common/widgets/custom_add_button.dart';
import 'package:test_app/common/widgets/user_places/user_places.dart';
import 'package:test_app/services/secure_storage.dart';
import 'package:location/location.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    HomePageMap(),
    ProfilePage(),
    UserPlaces(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.lightBlueOne,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_location_sharp),
            label: 'Places',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomePageMap extends StatefulWidget {
  @override
  _HomePageMapState createState() => _HomePageMapState();
}

class _HomePageMapState extends State<HomePageMap> {
  GoogleMapController? _controller;
  LatLng? _initialPosition;
  bool _loading = true;
  double _zoomLevel = 12.0;
  Marker? _searchMarker;

  final _locationController = Location();
  final _secureStorage = SecureStorage();

  void _onPlaceSelected(LatLng newPosition) {
    setState(() {
      _searchMarker = Marker(
        markerId: MarkerId("_searchMarker"),
        position: newPosition,
        icon: BitmapDescriptor.defaultMarker,
      );
    });
    _moveCamera(newPosition);
  }

  void _moveCamera(LatLng newPosition) {
    if (_controller != null) {
      _controller?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: newPosition, zoom: _zoomLevel),
        ),
      );
    } else {
      print("controle nulo");
    }
  }

  /*
  Adicionar função de adicionar local e salvar.
    Adicionar um botao que abre um modal e pergunta se a pessoa deseja adicionar
    o lugar. Armazenar os dados. Nome, descrição, data adicionada e latlng.
  */

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _cameraControllerFn(String zoomType) {
    setState(() {
      if (zoomType == "out") {
        _zoomLevel--;
      } else {
        _zoomLevel++;
      }
      _controller?.animateCamera(CameraUpdate.zoomTo(_zoomLevel));
    });
  }

  Future<void> _getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return Future.error('Location services are disabled.');
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permissionGranted == PermissionStatus.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    LocationData locationData = await _locationController.getLocation();
    setState(() {
      _initialPosition =
          LatLng(locationData.latitude!, locationData.longitude!);
      _loading = false;
    });
    //Listen to the users position.
    _locationController.onLocationChanged.listen((currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        setState(() {
          _initialPosition =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
          print("initialPos after:${_initialPosition}");
          _loading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Set<Marker> markers = {if (_searchMarker != null) _searchMarker!};
    return Stack(
      children: [
        Positioned.fill(
          child: _initialPosition == null
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: <Widget>[
                    Expanded(
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: _initialPosition!,
                          zoom: _zoomLevel,
                        ),
                        onMapCreated: (GoogleMapController controller) {
                          setState(() {
                            _controller = controller;
                          });
                        },
                        markers: markers,
                        myLocationButtonEnabled: true,
                        myLocationEnabled: true,
                      ),
                    ),
                  ],
                ),
        ),
        Positioned(
          top: MediaQuery.of(context).padding.top * 0.5,
          width: MediaQuery.of(context).size.width * 1,
          child: FindPlacesInput(onPlaceSelected: _onPlaceSelected),
        ),
        Positioned(
          bottom: 75.0,
          right: 10.0,
          child: Column(
            children: [
              FloatingActionButton(
                onPressed: () => _cameraControllerFn("out"),
                shape: CircleBorder(),
                backgroundColor: AppColors.whiteOne,
                child: Icon(
                  Icons.zoom_out,
                  size: 36.0,
                  color: AppColors.lightBlueOne,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              FloatingActionButton(
                onPressed: () => _cameraControllerFn("in"),
                shape: CircleBorder(),
                backgroundColor: AppColors.whiteOne,
                child: Icon(
                  Icons.zoom_in,
                  size: 36.0,
                  color: AppColors.lightBlueOne,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

//Exemplos de paginas para funcionar

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Página do Perfil'),
    );
  }
}

class FindPlacesInput extends StatefulWidget {
  final Function(LatLng) onPlaceSelected;

  FindPlacesInput({required this.onPlaceSelected});

  @override
  State<FindPlacesInput> createState() => _FindPlacesInputState();
}

class _FindPlacesInputState extends State<FindPlacesInput> {
  TextEditingController controller = TextEditingController();
  LatLng? _position;
  String? _selectedPlace;
  List<String>? _types;

  void _selectPlace(
    String latString,
    String lngString,
    List<String> types,
    String selectedPlace,
  ) {
    double lat = double.parse(latString);
    double lng = double.parse(lngString);
    LatLng position = LatLng(lat, lng);
    _position = position;
    _types = types;
    _selectedPlace = selectedPlace;
    print(position);
    widget.onPlaceSelected(position);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: <Widget>[
          placesAutoCompleteTextField(),
          CustomAddButton(
            selectedPlace: _selectedPlace,
            types: _types,
            pos: _position,
          ),
        ],
      ),
    );
  }

  placesAutoCompleteTextField() {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: GooglePlaceAutoCompleteTextField(
          textEditingController: controller,
          googleAPIKey: "AIzaSyAMFF8nu3NB_eys8FbaNU88GcaKOkV6tMQ",
          inputDecoration: InputDecoration(
              hintText: "Search your location",
              enabledBorder: InputBorder.none,
              icon: Icon(Icons.search_sharp),
              iconColor: Colors.black),
          debounceTime: 400,
          isLatLngRequired: true,
          getPlaceDetailWithLatLng: (Prediction prediction) {
            _selectPlace(
              prediction.lat!,
              prediction.lng!,
              prediction.types!,
              prediction.description!,
            );
          },

          itemClick: (Prediction prediction) {
            print("local: ${prediction.lat}");
            controller.text = prediction.description ?? "";
            controller.selection = TextSelection.fromPosition(
              TextPosition(offset: prediction.description?.length ?? 0),
            );
          },
          seperatedBuilder: Divider(
            color: AppColors.lightBlueTwo,
          ),
          containerHorizontalPadding: 10,
          boxDecoration: BoxDecoration(
            color: AppColors.whiteOne,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),

          // OPTIONAL// If you want to customize list view item builder
          itemBuilder: (context, index, Prediction prediction) {
            return Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Icon(Icons.location_on),
                  SizedBox(
                    width: 7,
                  ),
                  Expanded(child: Text(prediction.description ?? ""))
                ],
              ),
            );
          },

          isCrossBtnShown: true,

          // default 600 ms ,
        ),
      ),
    );
  }
}
