import 'package:begara_mobile/feauters/auth/domain/Entities/userStatus.dart';

class UserStatusModel extends UserStatusEntity{
  String profile_status;
  String payment_status;

  UserStatusModel({required this.profile_status, required this.payment_status})
      : super(profile_status: profile_status, payment_status: payment_status);

  Map<String,dynamic> toJson(){
    return {
      "profile_status":profile_status,
      "payment_status":payment_status
    };
  }

  factory UserStatusModel.fromJson(Map<String, dynamic> json){
    return UserStatusModel(
        profile_status: json["profile_status"],
        payment_status: json["payment_status"]);
  }
}