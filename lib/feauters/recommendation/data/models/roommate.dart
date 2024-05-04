import 'dart:ffi';

import 'package:begara_mobile/feauters/auth/data/model/user.dart';
import 'package:begara_mobile/feauters/recommendation/domain/entities/roommates.dart';

class RoommateModel extends Roommate {
  RoommateModel({
    required UserModel user,
    required double matchingScore,
  }) : super(user:user, matchingScore: matchingScore);

  factory RoommateModel.fromJson(Map<String, dynamic> temp) {
    return RoommateModel(
        user: UserModel.fromJson(temp["profile"]),
        matchingScore: temp["similarityScore"]);
  }
}
