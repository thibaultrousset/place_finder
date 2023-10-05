import 'package:place_finder/model/place.dart';

// Model for UI
class PlaceViewModel {
  final Place _place;

  PlaceViewModel({required Place place}) : _place = place;

  String get name {
    return _place.name ?? "";
  }

  double get latitude {
    return _place.lat ?? 0.0;
  }

  double get longitude {
    return _place.lng ?? 0.0;
  }

  String get icon {
    return _place.icon ?? "";
  }

  String get placeId {
    return _place.placeId ?? "";
  }
}
