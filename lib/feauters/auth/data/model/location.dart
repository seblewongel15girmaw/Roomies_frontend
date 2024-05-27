import 'package:begara_mobile/feauters/auth/domain/Entities/location.dart';

class LocationModel extends Location {
  LocationModel({
    required String displayName,
    required double lat,
    required double long,
  }) : super(displayName: displayName, lat: lat, long: long);
  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      displayName: json['display_name'],
      lat: double.parse(json['lat']),
      long: double.parse(json['lon']),
    );
  }
}
