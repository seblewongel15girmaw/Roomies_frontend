import 'dart:async';
import 'package:begara_mobile/feauters/auth/presentation/bloc/others/censor/censor_event.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/others/censor/censor_state.dart';
import 'package:bloc/bloc.dart';

class PassBloc extends Bloc<PassEvent,PassState>{
  PassBloc():super(Hidden()){
    on(passwordHandlerClicked);
  }

  FutureOr<void> passwordHandlerClicked(PassEvent event, Emitter emit) {
    if (state is Hidden){
      emit(Visible());
    }
    else{
      emit(Hidden());
    }
  }
}