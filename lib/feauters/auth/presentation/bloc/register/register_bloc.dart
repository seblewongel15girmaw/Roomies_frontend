
import 'dart:async';


import 'package:begara_mobile/feauters/auth/domain/Entities/user.dart';
import 'package:begara_mobile/feauters/auth/domain/repository/userRepository.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/register/register_event.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/register/register_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegBloc extends Bloc<RegEvent,RegisterState>{
  UserRepo userRepo;
  RegBloc(this.userRepo):super(Idle()){
    on(registerHandler);
  }
  

  FutureOr<void> registerHandler(RegEvent event, Emitter emit) async{
    UserEntity user= UserEntity(userName: event.userName, fullName: event.fullName, email: event.email,password: event.password);
    final response=await userRepo.createUser(user);
    emit(Registering());
    if (response==201){
      emit(RegisterSuccess());
    }
    else {
      emit(RegisterFailed());
    }
  }
}