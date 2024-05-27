import 'dart:async';

import 'package:begara_mobile/feauters/auth/domain/usecases/recover_password.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/recover_password/recover_password_event.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/recover_password/recover_password_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecoverPasswordBloc extends Bloc<RecoveryEmail, RecoverPasswordState>{
  final RecoverPassword recoverPassword;
  RecoverPasswordBloc(this.recoverPassword):super(Idle()){
    on<RecoveryEmail>(_recoverPassword);
  }

  FutureOr<void> _recoverPassword(RecoveryEmail event, Emitter emit) async{
    emit(RecoveringPassword());
    Params param=Params(email: event.email);
    final response= await recoverPassword(param);
    response.fold((l) => emit(RecoverFailed()), (r) => emit(SuccessfulyRecovered()));
  }
}