
import 'package:equatable/equatable.dart';
import 'package:begara_mobile/feauters/house/domain/entity/image_entity.dart';

class HouseEntity extends Equatable{
  final int houseId;
  final String location;
  final int numberOfRoom;
  final double price;
  final String description;
  final List<ImageEntity> Images;

  const HouseEntity(
      {required this.houseId, required this.description, required this.price, required this.location, required this.numberOfRoom, required this.Images});

  @override
  List<Object?> get props => [houseId, location, numberOfRoom, price, description, Images];
}