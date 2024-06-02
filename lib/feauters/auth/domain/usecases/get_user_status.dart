import 'package:begara_mobile/feauters/auth/domain/Entities/userStatus.dart';
import 'package:begara_mobile/feauters/auth/domain/repository/userStatusRepository.dart';

class GetUserStatus{
  UserStatusRepository userStatusRepository;

  GetUserStatus(this.userStatusRepository);

  Future<UserStatusEntity> call(String id) async{
    return await userStatusRepository.getUserStatus(id);
  }
}