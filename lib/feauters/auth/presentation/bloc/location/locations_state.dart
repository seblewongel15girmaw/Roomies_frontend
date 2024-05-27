
import 'package:begara_mobile/feauters/recommendation/presentation/bloc/roommate/roommate_state.dart';

import '../../../domain/Entities/location.dart';

abstract class LocationState{}

class Idle extends LocationState{}

class LoadLocations extends LocationState{
  List<Location> locations;
  LoadLocations({required this.locations});
  
}

class NoMatch extends LocationState{}

class LoadFailed extends LocationState{}