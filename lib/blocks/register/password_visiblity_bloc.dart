import 'dart:async';

import 'package:begara_mobile/blocks/register/password_visiblity_event.dart';
import 'package:begara_mobile/blocks/register/password_visiblity_state.dart';
import 'package:bloc/bloc.dart';

class PassBloc extends Bloc<PassEvent,PassState> {
  PassBloc():super(HiddenPassword()){
    on<PassEvent>(_onPasswordVisiblityClicked);
  }

void _onPasswordVisiblityClicked(PassEvent event, Emitter emit) {
    if (state is HiddenPassword){
      emit(VisiblePassword());
    }
    else {
      emit(HiddenPassword());
    }
  }
}