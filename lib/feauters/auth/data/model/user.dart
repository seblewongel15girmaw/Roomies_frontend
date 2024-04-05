import 'package:begara_mobile/feauters/auth/domain/Entities/user.dart';

class UserModel extends UserEntity{
  const UserModel({
   String? fullName,
   String? userName,
   String? email,
   String?password,
   int? age,
   String? bio,
   String? phoneNumber,
   String? address,
   String? jobStatus,
   String? gender,
   int? budget,
   String? image,
   String? image2,

  });
  factory UserModel.fromJson(Map<String,dynamic>map){
    return UserModel(
      fullName: map["fullName"]??"",
      userName: map['userName']??"",
      email: map['email']??"",
      password: map['password']??"",
      age:map["age"]??"",
      bio:map["bio"]??"",
      phoneNumber:map["phoneNumber"]??"",
      address: map['address']??"",
      jobStatus: map['jobStatus']??"",
      gender: map['gender']??"",
      budget: map['budget']??"",
      image:map['image']??"",
      image2:map["image2"]??""
    );
  }
 
}