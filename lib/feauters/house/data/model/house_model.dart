
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:begara_mobile/feauters/house/data/model/image_model.dart';
import 'package:begara_mobile/feauters/house/domain/entity/house_entity.dart';
import 'package:begara_mobile/feauters/house/domain/entity/image_entity.dart';

class HouseModel extends Equatable{
  final int houseId;
  final LocationModel location;
  final int numberOfRoom;
  final double price;
  final int brokerId;
  final String description;
  final List<ImageModel> Images;

  const HouseModel({required this.houseId, required this.description, required this.Images,required this.price,required this.brokerId ,required this.location, required this.numberOfRoom});

  Map<String,dynamic> toJson(){
    return {
      "houseId":houseId,
      "location":jsonEncode(location.toJson()),
      "numberOfRoom":numberOfRoom,
      "price":price,
      "description":description,
      "Images":Images,
      "brokerId":brokerId
    };
  }


  factory HouseModel.fromJson(Map<String, dynamic> json){
    List<dynamic> imagesJson = json['Images'] ?? [];
    List<ImageModel> images = imagesJson.map((imageJson) => ImageModel.fromJson(imageJson)).toList();
    return HouseModel(
      houseId:json["houseId"],
      location: LocationModel.fromJson(jsonDecode(json["location"])),
      numberOfRoom: json["numberOfRoom"],
      price:json["price"].toDouble(),
      Images: images,
      description: json["description"],
      brokerId: json["brokerId"]
    );
  }

  HouseEntity toEntity(){
List<ImageEntity> images= Images.map((image) => image.toEntity()).toList();
    return HouseEntity(houseId: houseId, description: description, Images: images, price: price, location: location,brokerId: brokerId ,numberOfRoom: numberOfRoom);
  }

  @override
  List<Object?> get props => [houseId, location, numberOfRoom, price, description, brokerId,Images];
}



class LocationModel extends Location {
  LocationModel({
    required String displayName,
    required double lat,
    required double long,
  }) : super(displayName: displayName, lat: lat, long: long);
  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      displayName: json['display_name'],
      lat:json['lat'] is String? double.parse(json['lat']):json['lat'],
      long: json['lon'] is String? double.parse(json['lon']):json['lon'],
    );
  }
}
