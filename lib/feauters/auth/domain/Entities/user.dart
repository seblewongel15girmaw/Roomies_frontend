import 'package:equatable/equatable.dart';

class UserEntity extends Equatable{
  final String? fullName;
  final String? userName;
  final String? email;
  final String?password;
  final int? age;
  final String? bio;
  final String? phoneNumber;
  final String? address;
  final String? jobStatus;
  final String? gender;
  final int? budget;
  final String? image;
  final String? image2;
  const UserEntity({
    this.fullName,this.userName,this.email,this.password, this.age,this.bio,this.phoneNumber,this.address,this.jobStatus,this.gender,this.budget,this.image,this.image2
  });
  
  @override
  // TODO: implement props
  List<Object?> get props {
    return [
      age,bio,phoneNumber,address,jobStatus,gender,budget,image,image2
    ];
  }

   Map<String, dynamic> toJson() {
    return {
      "full_name":fullName,
      "username":userName,
      "email":email,
      "password":password,
      "age": age,
      "bio": bio,
      "phone_number": phoneNumber,
      "address": address,
      "job_status": jobStatus,
      "gender": gender,
      "budget": budget,
      "image": image,
      "image2": image2,
    };
  }
}