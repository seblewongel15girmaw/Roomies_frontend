import 'package:begara_mobile/feauters/recommendation/domain/entities/roommates.dart';

abstract class RoommateState{}

class Idle extends RoommateState{}

class Loading extends RoommateState{}

class LoadSuccess extends RoommateState{
  int userId;
  List<Roommate> roommmates;
  LoadSuccess({ required this.roommmates, required this.userId});
}

class LoadFailed extends RoommateState{}