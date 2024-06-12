import 'package:begara_mobile/feauters/auth/domain/Entities/userStatus.dart';

abstract class UserStatusState{}

class Idle extends UserStatusState{}

class StatusSuccess extends UserStatusState{
  UserStatusEntity user;
  StatusSuccess(this.user);
}

class StatusFailed extends UserStatusState{}