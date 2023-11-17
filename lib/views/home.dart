import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:place_finder/view_models/place_list_view_model.dart';
import 'package:place_finder/view_models/place_view_model.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _getCurrentPosition();
  }

   Position? position;

  Future<void> _getCurrentPosition() async {
    bool serviceEnabled;
LocationPermission permission;

serviceEnabled = await Geolocator.isLocationServiceEnabled();
if (!serviceEnabled) {
  return Future.error('Location services are disabled');
}

permission = await Geolocator.checkPermission();
if (permission == LocationPermission.denied) {
  permission = await Geolocator.requestPermission();
  if (permission == LocationPermission.denied) {
    return Future.error('Location permissions are denied');
  }
}

if (permission == LocationPermission.deniedForever) {
  return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
}

if(permission == LocationPermission.always || permission == LocationPermission.whileInUse){
 position  = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
}


  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    _controller.complete(controller);
    if (position != null ){
  controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(position!.latitude, position!.longitude), zoom: 14)));
    }

  
  }

  Set<Marker> _markers(List<PlaceViewModel> places) {
    return places.map((place) {
      return Marker(
        markerId: MarkerId(place.placeId),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: place.name),
        position: LatLng(place.latitude, place.longitude),
      );
    }).toSet();
  }

  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<PlaceListViewModel>(context);
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            GoogleMap(
                onMapCreated: _onMapCreated,
                markers: _markers(vm.placeListViewModel),
                initialCameraPosition: const CameraPosition(
                    target: LatLng(43.53202309513262, 5.44870502622721), zoom: 14)),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextField(
                  onSubmitted: (value) {
                    vm.populateSearch(
                        value, position!.latitude, position!.longitude);
                  },
                  decoration: const InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      labelText: "Search"),
                ),
              ),
            ),
            Visibility(
              visible: vm.placeListViewModel.isNotEmpty,
              child: Positioned(
                bottom: 5,
                left: 5,
                child: MaterialButton(
                  onPressed: () {},
                  color: Colors.grey.withOpacity(0.5),
                  child: const Text("Show List"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
