import 'package:begara_mobile/core/error/errors.dart';
import 'package:begara_mobile/feauters/auth/data/data_source/userStatus_data_source.dart';
import 'package:begara_mobile/feauters/auth/domain/Entities/userStatus.dart';
import 'package:begara_mobile/feauters/auth/domain/repository/userStatusRepository.dart';
import 'package:begara_mobile/feauters/house/core/error/exception.dart';

class UserStatusRepoImpl implements UserStatusRepository{
  UserStatusDataSource userStatusDataSource;

  UserStatusRepoImpl(this.userStatusDataSource);

  @override
  Future<UserStatusEntity> getUserStatus(String id) async{
     return await userStatusDataSource.getUserStatus(id);
   }

}