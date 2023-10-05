class UrlHelper {
  static Uri urlForKeywordAndLocation(
      String keyword, double latitude, double longitude) {
    return Uri.https(
        'maps.googleapis.com', 'maps/api/place/nearbysearch/json', {
      'keyword': keyword,
      'location': '$latitude,$longitude',
      'radius': '1500',
      'type': 'retaurant',
      'key': 'AIzaSyCjeNCmWYT3TeYiRqiXCLk4kgi0oJW1y2g'
    });
  }
}
