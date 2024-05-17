
import 'package:equatable/equatable.dart';

class BrokerEntity extends Equatable{
  final String fullName;
  final String phoneNumber1;
  final String phoneNumber2;
  final String address;
  final String photo;
  final String id;

  const BrokerEntity({required this.fullName, required this.address,
    required this.phoneNumber1, required this.phoneNumber2, required this.id, required this.photo});

  @override
  // TODO: implement props
  List<Object?> get props => [id, address, photo, phoneNumber1, phoneNumber2, fullName];
}