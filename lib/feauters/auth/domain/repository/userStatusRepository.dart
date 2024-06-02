import 'package:begara_mobile/feauters/auth/domain/Entities/userStatus.dart';

abstract class UserStatusRepository{
  Future<UserStatusEntity> getUserStatus(String id);
}