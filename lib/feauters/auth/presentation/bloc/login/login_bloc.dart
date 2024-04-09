
import 'dart:async';

import 'package:begara_mobile/core/error/errors.dart';
import 'package:begara_mobile/feauters/auth/domain/repository/userRepository.dart';
import 'package:begara_mobile/feauters/auth/domain/usecases/login_user.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/login/login_event.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/login/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogBloc extends Bloc<LogEvent,LogState>{
  final LoginUser loginUser;
  LogBloc(this.loginUser):super(Idle()){
    on(loginHandler);
  }

  FutureOr<void> loginHandler(LogEvent event, Emitter<LogState> emit) async{
    Params params=Params(username: event.userName, password: event.password);
    final response= await loginUser(params);
    
    if (response.isRight()){
      emit(LogSuccess());
    }
    else {
      emit(LogFailure());
    }
    
  }
}