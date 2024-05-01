import 'dart:ffi';

import 'package:begara_mobile/feauters/auth/domain/Entities/user.dart';
import 'package:equatable/equatable.dart';

class Roommate extends Equatable{
  UserEntity? user;
  Float? matchingScore;
  Roommate({ this.user,  this.matchingScore});
  
  @override
  // TODO: implement props
  List<Object?> get props => [
    user, matchingScore
  ];
}

