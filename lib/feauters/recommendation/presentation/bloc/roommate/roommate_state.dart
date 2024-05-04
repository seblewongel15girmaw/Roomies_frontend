import 'package:begara_mobile/feauters/recommendation/domain/entities/roommates.dart';

abstract class RoommateState{}

class Idle extends RoommateState{}

class Loading extends RoommateState{}

class LoadSuccess extends RoommateState{
  List<Roommate> roommmates;
  LoadSuccess({ required this.roommmates});
}

class LoadFailed extends RoommateState{}