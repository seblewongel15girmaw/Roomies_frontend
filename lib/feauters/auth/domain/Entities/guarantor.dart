import 'package:equatable/equatable.dart';

class Guarantor extends Equatable{

  final String fullName;
  final String phoneNumber;
  final Map address;
  final String gender;
  final String image;
  Guarantor({required this.fullName, required this.phoneNumber, required this.address, required this.gender, required this.image});
  @override
  // TODO: implement props
  List<Object?> get props {
    return [fullName,phoneNumber,address,gender,image];
  }
  Map<String, dynamic> toJson() {
    return {
      "full_name": fullName,
      "phone_number": phoneNumber,
      "address": address,
      "gender": gender,
      "image": image,
    };
  }

  }