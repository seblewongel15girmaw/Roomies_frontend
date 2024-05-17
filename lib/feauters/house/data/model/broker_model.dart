
import 'package:equatable/equatable.dart';

class BrokerModel extends Equatable {
  final String id;
  final String fullName;
  final String phoneNumber1;
  final String phoneNumber2;
  final String address;
  final String photo;

  const BrokerModel(
      {required this.id, required this.fullName, required this.address,
        required this.phoneNumber1, required this.phoneNumber2, required this.photo});

  @override
  List<Object?> get props =>
      [id, fullName, address, phoneNumber1, phoneNumber2, photo];

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "fullName": fullName,
      "phoneNumber1": phoneNumber1,
      "phoneNumber2": phoneNumber2,
      "address": address,
      "photo": photo,
    };
  }

  factory BrokerModel.fromJson(Map<String, dynamic> json){
    return BrokerModel(
      id: json["id"],
      fullName: json["fullName"],
      phoneNumber1: json["phoneNumber1"],
      phoneNumber2: json["phoneNumber2"],
      address: json["address"],
      photo: json["photo"],
    );
  }
}