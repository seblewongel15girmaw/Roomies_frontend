import 'dart:async';
import 'package:begara_mobile/feauters/auth/domain/usecases/get_locations.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/location/locations_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'locations_state.dart';

class LocationBloc extends Bloc<LocationEvent,LocationState>{
  GetLocations getLocations;
  LocationBloc(this.getLocations):super(Idle()){
    on<LocationEvent>(_loadingLocation);
  }

  FutureOr<void> _loadingLocation(LocationEvent event, Emitter<LocationState> emit) async{
    if(event is SearchEvent){
      Params params= Params(event.query);

    final locations= await getLocations(params);
    locations.fold((l) => emit(LoadFailed()), (location) => emit(LoadLocations(locations: location)))
    ;}
    else{
      emit(Idle());
    }
  }
}