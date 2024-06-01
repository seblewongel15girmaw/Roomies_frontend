import 'dart:async';

import 'package:begara_mobile/feauters/auth/domain/usecases/unsubscribe_user.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/deactivate/deactivate_event.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/deactivate/deactivate_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeactivateBloc extends Bloc<DeactivateEvent, DeactivateState>{
  UnsubscribeUser unsubscribeUser;
  DeactivateBloc(this.unsubscribeUser):super(IdleState()){
    on<DeactivateEvent>(_onDeactivateUser);
  }

  FutureOr<void> _onDeactivateUser(DeactivateEvent event, Emitter<DeactivateState> emit) async{
    Params param= Params(password: event.password);
    final response= await unsubscribeUser(param);
    response.fold((ifLeft){
      print("it is not tbh");
      emit(DeactivateFailed());
    }, (ifRight){
      print('it working fine');
      emit(DeactivateSuccess());
    });
  }
}