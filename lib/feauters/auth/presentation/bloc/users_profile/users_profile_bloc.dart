import 'dart:async';

import 'package:begara_mobile/feauters/recommendation/domain/usecases/get_roommate.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/users_profile/users_profile_event.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/users_profile/users_profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfileBloc extends Bloc<UserProfileEvent,UserProfileState>{
  final GetRoommate getRoommate;
  UserProfileBloc(this.getRoommate):super(Idle()){
    on<UserProfileEvent>(
      _loadUserProfile
    );
  }
  

  FutureOr<void> _loadUserProfile(UserProfileEvent event, Emitter emit) async{
    emit (LoadingUserProfile());
    Params param= Params(id:event.id);
    final result= await getRoommate(param);
    result.fold((l){
      emit(UserProfileFailed());
    }, (user){
      emit(UserProfileSuccess(user: user));
    });
    

  }
}