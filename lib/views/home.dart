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
  }

  late Position position;

  Future<void> _onMapCreated(GoogleMapController controller) async {
    _controller.complete(controller);
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position);
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(position.latitude, position.longitude), zoom: 14)));
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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            GoogleMap(
                onMapCreated: _onMapCreated,
                markers: _markers(vm.placeListViewModel),
                initialCameraPosition: const CameraPosition(
                    target: LatLng(45.541563, -122.677433), zoom: 14)),
            TextField(
              onSubmitted: (value) {
                vm.populateSearch(value, position.latitude, position.longitude);
              },
              decoration: const InputDecoration(
                  fillColor: Colors.white, filled: true, labelText: "Search"),
            )
          ],
        ),
      ),
    );
  }
}
