import 'dart:ffi';

import 'package:begara_mobile/feauters/auth/domain/Entities/user.dart';
import 'package:equatable/equatable.dart';

class Roommate extends Equatable{
  UserEntity user;
  double matchingScore;
  Roommate({
  required this.user, 
  required this.matchingScore});
  
  @override
  // TODO: implement props
  List<Object?> get props => [
     matchingScore
  ];
}

