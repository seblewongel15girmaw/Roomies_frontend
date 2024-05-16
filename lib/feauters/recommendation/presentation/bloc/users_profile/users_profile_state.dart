abstract class UserProfileState{
}

class Idle extends UserProfileState{}

class LoadingUserProfile extends UserProfileState{
}

class UserProfileSuccess extends UserProfileState{
  dynamic user;
  UserProfileSuccess({this.user});

}

class UserProfileFailed extends UserProfileState{}