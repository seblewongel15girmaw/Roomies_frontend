import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? fullName;
  final String? userName;
  final String? email;
  final String? password;
  final int? age;
  final String?religion;
  final String? bio;
  final String? phoneNumber;
  final Map? address;
  final String? jobStatus;
  final String? gender;
  final int? budget;
  final String? image;
  final String? image2;
  final String? pet;
  final String? religiousSimilarity;
  final String? privacy;
  final String? socialize;
  final String? smoking;

  const UserEntity(
      {this.fullName,
      this.userName,
      this.email,
      this.password,
      this.age,
      this.religion,
      this.bio,
      this.phoneNumber,
      this.address,
      this.jobStatus,
      this.gender,
      this.budget,
      this.image,
      this.image2,
      this.pet,
      this.privacy,
      this.religiousSimilarity,
      this.smoking,
      this.socialize});

  @override
  // TODO: implement props
  List<Object?> get props {
    return [
      age,
      bio,
      phoneNumber,
      address,
      jobStatus,
      religion,
      gender,
      budget,
      image,
      image2,
      pet,
      privacy,
      religiousSimilarity,
      smoking,
      socialize
    ];
  }

  Map<String, dynamic> toJson() {
    return {
      "full_name": fullName,
      "username": userName,
      "email": email,
      "password": password,
      "age": age,
      "bio": bio,
      "phone_number": phoneNumber,
      "address": address,
      "job_status": jobStatus,
      "gender": gender,
      "budget": budget,
      "image": image,
      "image2": image2,
      "pets": pet,
      "privacy": privacy,
      "religious_compatibility": religiousSimilarity,
      "smoking": smoking,
      "socialize": socialize,
      "religion":religion
    };
  }
}
