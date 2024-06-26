import 'package:equatable/equatable.dart';

import 'location.dart';

class UserEntity extends Equatable {
  final int id;
  final String fullName;
  final String userName;
  final String email;
  final String password;
  final int age;
  final String religion;
  final String bio;
  final String phoneNumber;
  final Location address;
  final String jobStatus;
  final String gender;
  final int budget;
  final String image;
  final String image2;
  final String pet;
  final String religiousSimilarity;
  final String privacy;
  final String socialize;
  final String smoking;
  final int profileStatus;
  final int activateStatus;
  final String fcmToken;

  const UserEntity(
      { required this.id,
        required this.fullName,
      required this.userName,
      required this.email,
      required this.password,
      required this.age,
      required this.religion,
      required this.bio,
      required this.phoneNumber,
      required this.address,
      required this.jobStatus,
      required this.gender,
      required this.budget,
      required this.image,
      required this.image2,
      required this.pet,
      required this.privacy,
      required this.religiousSimilarity,
      required this.smoking,
      required this.socialize,
      required this.profileStatus,
      required this.activateStatus,
      required this.fcmToken});

  @override
  // TODO: implement props
  List<Object?> get props {
    return [
      id,
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
      socialize,
      activateStatus,
      profileStatus,
      fcmToken
    ];
  }

  Map<String, dynamic> toJson() {
    return {
      "id":id,
      "full_name": fullName,
      "username": userName,
      "email": email,
      "password": password,
      "age": age,
      "bio": bio,
      "phone_number": phoneNumber,
      "address": address.toJson(),
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
      "religion":religion,
      "profile_status": profileStatus,
      "activate_status":activateStatus,
      "fcm_token":fcmToken
    };
  }
}
