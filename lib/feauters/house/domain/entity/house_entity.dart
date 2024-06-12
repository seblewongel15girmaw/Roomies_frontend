
import 'package:equatable/equatable.dart';
import 'package:begara_mobile/feauters/house/domain/entity/image_entity.dart';

class HouseEntity extends Equatable{
  final int houseId;
  final Location location;
  final int numberOfRoom;
  final double price;
  final String description;
  final List<ImageEntity> Images;

  const HouseEntity(
      {required this.houseId, required this.description, required this.price, required this.location, required this.numberOfRoom, required this.Images});

  @override
  List<Object?> get props => [houseId, location, numberOfRoom, price, description, Images];
}



class Location extends Equatable{
  final String displayName;
  final double lat;
  final double long;
  Location({required this.displayName, required this.lat, required this.long});

  @override
  // TODO: implement props
  List<Object?> get props => [
    displayName,lat,long
  ];
  Map <String,dynamic> toJson(){
    return {"display_name":displayName,
      "lat":lat,
      "lon":long};
  }
}