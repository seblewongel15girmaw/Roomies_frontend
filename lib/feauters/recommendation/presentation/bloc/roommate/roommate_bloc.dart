import 'dart:async';

import 'package:begara_mobile/feauters/recommendation/domain/usecases/get_all_roommate.dart';
import 'package:begara_mobile/feauters/recommendation/presentation/bloc/roommate/roommate_event.dart';
import 'package:begara_mobile/feauters/recommendation/presentation/bloc/roommate/roommate_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoommateBloc extends Bloc<RoommateEvent,RoommateState> {
  final GetAllRoommates getAllRoommates;
  RoommateBloc(this.getAllRoommates):super(Idle()){
    on <RoommateEvent>(_loadPossilbleMatches);
  }
  
 

  FutureOr<void> _loadPossilbleMatches(RoommateEvent event, Emitter emit) async {
    emit(Loading());
    Params param=Params(id: 10);
    final results=await getAllRoommates(param);
    
    
    results.fold((l) {
      emit(LoadFailed());
    }, (roomates){
      print("its success you guys");
      emit(LoadSuccess(roommmates: roomates));
    });
    // if(results.isRight()){
    //   print("here is the result obtained");
    //   print(results.getOrElse(() => []));
    //   emit(LoadSuccess(roommmates:results.getOrElse(() => [])));
    // }
    // else{
    //   emit(LoadFailed());
    // }
  }
}