import 'dart:async';

import 'package:begara_mobile/feauters/auth/presentation/bloc/others/dropDown/dropdown_event.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/others/dropDown/dropdown_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DropDownBloc extends Bloc<DropDownEvent,DropDownState>{
  DropDownBloc():super(Idle()){
    on<DropDownEvent>(_dropDownEventHandler);
  }

  FutureOr<void> _dropDownEventHandler(DropDownEvent event, Emitter emit) {
    emit(Selected());
  }
}