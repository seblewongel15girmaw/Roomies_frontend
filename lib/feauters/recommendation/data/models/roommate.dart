
import 'package:begara_mobile/feauters/auth/data/model/user.dart';
import 'package:begara_mobile/feauters/recommendation/domain/entities/roommates.dart';

class RoommateModel extends Roommate {
  RoommateModel({
    required UserModel user,
    required num matchingScore,
  }) : super(user:user, matchingScore: matchingScore);

  factory RoommateModel.fromJson(Map<String, dynamic> temp) {
    print("the data recieved is $temp");
    return RoommateModel(
        user: UserModel.fromJson(temp["profile"]),
        matchingScore: temp["similarityScore"].toDouble());
  }
}
