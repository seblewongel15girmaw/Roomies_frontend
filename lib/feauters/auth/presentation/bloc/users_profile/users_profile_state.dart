import 'package:begara_mobile/feauters/auth/domain/Entities/user.dart';

abstract class UserProfileState{
}

class Idle extends UserProfileState{}

class LoadingUserProfile extends UserProfileState{
}

class UserProfileSuccess extends UserProfileState{
  UserEntity user;
  UserProfileSuccess({required this.user});

}

class UserProfileFailed extends UserProfileState{}