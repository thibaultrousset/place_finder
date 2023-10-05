import 'package:flutter/material.dart';
import 'package:place_finder/model/place.dart';
import 'package:place_finder/services/web_service.dart';
import 'package:place_finder/view_models/place_view_model.dart';

enum LoadingStatus {
  completed,
  empty,
  searching,
}

class PlaceListViewModel extends ChangeNotifier {
  List<PlaceViewModel> placeListViewModel = <PlaceViewModel>[];

  LoadingStatus loadingStatus = LoadingStatus.searching;

  void populateSearch(String filter, lat, lng) async {
    print(filter);
    print(lat);
    print(lng);
    loadingStatus = LoadingStatus.searching;

    List<Place> places =
        await Webservice().fetchPlacesByKeywordAndPosition(filter, lat, lng);
    placeListViewModel = places.map((e) => PlaceViewModel(place: e)).toList();
    print(placeListViewModel);
    loadingStatus = placeListViewModel.isEmpty
        ? LoadingStatus.empty
        : LoadingStatus.completed;

    notifyListeners();
  }
}
