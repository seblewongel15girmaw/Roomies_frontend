
import 'package:equatable/equatable.dart';
import 'package:begara_mobile/feauters/house/data/model/image_model.dart';
import 'package:begara_mobile/feauters/house/domain/entity/house_entity.dart';
import 'package:begara_mobile/feauters/house/domain/entity/image_entity.dart';

class HouseModel extends Equatable{
  final int houseId;
  final String location;
  final int numberOfRoom;
  final double price;
  final String description;
  final List<ImageModel> Images;

  const HouseModel({required this.houseId, required this.description, required this.Images,required this.price, required this.location, required this.numberOfRoom});

  Map<String,dynamic> toJson(){
    return {
      "houseId":houseId,
      "location":location,
      "numberOfRoom":numberOfRoom,
      "price":price,
      "description":description,
      "Images":Images
    };
  }

  factory HouseModel.fromJson(Map<String, dynamic> json){
    List<dynamic> imagesJson = json['Images'] ?? [];
    List<ImageModel> images = imagesJson.map((imageJson) => ImageModel.fromJson(imageJson)).toList();
    return HouseModel(
      houseId:json["houseId"],
      location: json["location"],
      numberOfRoom: json["numberOfRoom"],
      price:json["price"].toDouble(),
      Images: images,
      description: json["description"]
    );
  }

  HouseEntity toEntity(){
List<ImageEntity> images= Images.map((image) => image.toEntity()).toList();
    return HouseEntity(houseId: houseId, description: description, Images: images, price: price, location: location, numberOfRoom: numberOfRoom);
  }

  @override
  List<Object?> get props => [houseId, location, numberOfRoom, price, description, Images];
}