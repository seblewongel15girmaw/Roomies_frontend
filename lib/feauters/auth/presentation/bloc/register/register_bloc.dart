
import 'dart:async';


import 'package:begara_mobile/feauters/auth/domain/Entities/user.dart';
import 'package:begara_mobile/feauters/auth/domain/repository/userRepository.dart';
import 'package:begara_mobile/feauters/auth/domain/usecases/register_user.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/register/register_event.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/register/register_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegBloc extends Bloc<RegEvent,RegisterState>{
  final RegisterUser registerUser;
  RegBloc(this.registerUser):super(Idle()){
    on(registerHandler);
  }
  

  FutureOr<void> registerHandler(RegEvent event, Emitter emit) async{
    UserEntity user= UserEntity(userName: event.userName, fullName: event.fullName, email: event.email,password: event.password);
    Params params=Params(user: user);
    final response=await registerUser(params);
    emit(Registering());
    if (response.isRight()){
      emit(RegisterSuccess());
    }
    else {
      emit(RegisterFailed());
    }
  }
}