import 'dart:async';

import 'package:begara_mobile/feauters/auth/domain/usecases/logout_user.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/logout/logout_event.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/logout/logout_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogoutBloc extends Bloc<LogoutEvent,LogOutState>{
  LogOutUser logOutUser;
  LogoutBloc(this.logOutUser):super(LoggedIn()){
    on<LogoutEvent>(_logoutClicked);
  }

  FutureOr<void> _logoutClicked(LogoutEvent event, Emitter emit) async{
    Params param= Params();
    final response= await logOutUser(param);
    response.fold((ifLeft){
      emit(LogoutFailed());
    }, (ifRight){
      emit(LoggedOut());
    });
    
  }
}