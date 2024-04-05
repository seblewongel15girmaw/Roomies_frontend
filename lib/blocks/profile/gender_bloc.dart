import 'dart:async';

import 'package:begara_mobile/blocks/profile/gender_event.dart';
import 'package:begara_mobile/blocks/profile/gender_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RadioBloc extends Bloc<RadioEvent,RadioState>{
  RadioBloc():super(Idle()) {
    on<RadioEvent>(_changeGenderClicked);
  }

  FutureOr<void> _changeGenderClicked(RadioEvent event, Emitter emit) {
    emit(Idle());
    if (event.gender=="female"){
      emit(FemaleSelected());
    }
    else
    {
      emit(MaleSelected());
    }
  }
}