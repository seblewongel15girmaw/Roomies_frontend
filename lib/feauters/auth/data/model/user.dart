import 'dart:convert';

import 'package:begara_mobile/feauters/auth/domain/Entities/user.dart';

class UserModel extends UserEntity {
  const UserModel({
    required String fullName,
    required String userName,
    required String email,
    required String password,
    required int age,
    required String bio,
    required String phoneNumber,
    required Map address,
    required String jobStatus,
    required String gender,
    required int budget,
    required String image,
    required String image2,
    required String religion,
    required String pet,
    required String privacy,
    required String religiousSimilarity,
    required String smoking,
    required String socialize
  }) : super(
            fullName: fullName,
            userName: userName,
            email: email,
            password: password,
            age: 0,
            religion: religion,
            bio: bio,
            phoneNumber: phoneNumber,
            address: address,
            jobStatus: jobStatus,
            gender: gender,
            budget: budget,
            image: image,
            image2: image2,
            pet: pet,
            privacy: privacy,
            religiousSimilarity: religiousSimilarity,
            smoking: smoking,
            socialize: socialize);
  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
        fullName: map["full_name"] ?? "",
        userName: map['username'] ?? "",
        email: map['email'] ?? "",
        password: map['password'] ?? "",
        age: map["age"] ?? "",
        bio: map["bio"] ?? "",
        phoneNumber: map["phone_number"] ?? "",
        address: json.decode(map['address']) ?? {"":""},
        jobStatus: map['job_status'] ?? "",
        gender: map['gender'] ?? "",
        budget: map['budget'] ?? "",
        image: map['image'] ?? "",
        image2: map["personal_id"] ?? "",
        religion: map["religion"]??"",
        religiousSimilarity: map["religiousSimilarity"]??"",
        pet: map['pet']??'',
        privacy: map['privacy']??'',
        smoking: map['smoking']??'',
        socialize: map['socialize']??'');
  }
}
