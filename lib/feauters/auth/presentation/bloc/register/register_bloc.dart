import 'dart:async';

import 'package:begara_mobile/feauters/auth/domain/Entities/user.dart';
import 'package:begara_mobile/feauters/auth/domain/repository/userRepository.dart';
import 'package:begara_mobile/feauters/auth/domain/usecases/register_user.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/register/register_event.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/register/register_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegBloc extends Bloc<RegEvent, RegisterState> {
  final RegisterUser registerUser;
  RegBloc(this.registerUser) : super(Idle()) {
    on(registerHandler);
  }

  FutureOr<void> registerHandler(RegEvent event, Emitter emit) async {
    String username=event.userName;
    String fullName=event.fullName;
    String password=event.password;
    String email=event.email;
    Params params = Params(userName: username, fullName: fullName, password: password, email: email);
    final response = await registerUser(params);
    emit(Registering());
    if (response.isRight()) {
      emit(RegisterSuccess());
    } else {
      emit(RegisterFailed());
    }
  }
}
