import 'dart:async';

import 'package:begara_mobile/feauters/recommendation/domain/usecases/get_roommate.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/users_profile/users_profile_event.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/users_profile/users_profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/util/sharedPreference.dart';
import '../../../data/utils/functions.dart';

class UserProfileBloc extends Bloc<UserProfileEvent,UserProfileState>{
  final GetRoommate getRoommate;
  UserProfileBloc(this.getRoommate):super(ProfileIdle()){
    on<UserProfileEvent>(
      _loadUserProfile
    );
  }
  

  FutureOr<void> _loadUserProfile(UserProfileEvent event, Emitter emit) async{
    emit (LoadingUserProfile());
    final token = await SharedPreferencesService.getString("tokens");
    final userId = decodeJwt(token!)["userId"];
    Params param= Params(id:userId);
    final result= await getRoommate(param);
    result.fold((l){
      emit(UserProfileFailed());
    }, (user){
      emit(UserProfileSuccess(user: user));
    });
    

  }
}