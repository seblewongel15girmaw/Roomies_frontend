import 'dart:ffi';

import 'package:begara_mobile/feauters/auth/data/model/user.dart';
import 'package:begara_mobile/feauters/recommendation/domain/entities/roommates.dart';

class RoommateModel extends Roommate{

  RoommateModel({
    required UserModel user,
    required Float matchingScore,
  });

  factory RoommateModel.fromJson(Map<String,dynamic> temp){
    return RoommateModel(user: temp["user"], matchingScore: temp["matchingScore"]);
  }

}