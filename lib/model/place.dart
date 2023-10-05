// model from DB
class Place {
  final String? name;
  final double? lat;
  final double? lng;
  final String? icon;
  final String? placeId;

  Place({this.name, this.lat, this.lng, this.icon, this.placeId});
  factory Place.fromJSON(Map<String, dynamic> json) {
    return Place(
      name: json["name"],
      lat: json["geometry"]["location"]["lat"],
      lng: json["geometry"]["location"]["lng"],
      icon: json["icon"],
      placeId: json["place_id"],
    );
  }
}
