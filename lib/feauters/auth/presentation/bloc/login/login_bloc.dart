
import 'dart:async';

import 'package:begara_mobile/feauters/auth/domain/repository/userRepository.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/login/login_event.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/login/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogBloc extends Bloc<LogEvent,LogState>{
  final UserRepo userRepo;
  LogBloc(this.userRepo):super(Idle()){
    on(loginHandler);
  }

  FutureOr<void> loginHandler(LogEvent event, Emitter<LogState> emit) async{
    int response= await userRepo.loginUser(event.userName,event.password);
    if (response==200){
      emit(LogSuccess());
    }
    else {
      emit(LogFailure());
    }
    
  }
}