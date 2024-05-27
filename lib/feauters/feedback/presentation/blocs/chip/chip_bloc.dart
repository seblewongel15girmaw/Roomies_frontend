import 'dart:async';

import 'package:begara_mobile/feauters/feedback/presentation/blocs/chip/chip_event.dart';
import 'package:begara_mobile/feauters/feedback/presentation/blocs/chip/chip_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChipBloc extends Bloc<SelectChipEvent,ChipState>{
  ChipBloc():super(UnSelected()){
    on<SelectChipEvent>(_selectChip);
  }

  FutureOr<void> _selectChip(SelectChipEvent event, emit) {
    if(event.isSelected==true){
      emit(Selected());
    }
    else{
      emit(UnSelected());
    }
  }
}