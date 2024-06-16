import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'id_image_event.dart';
import 'id_image_state.dart';

class IdImageBloc extends Bloc<IdClicked, IdState> {
  IdImageBloc() : super(IdleId()) {
    on<IdClicked>(_idClicked);
  }

  FutureOr<void> _idClicked(IdClicked event, Emitter emit) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      emit(IdSuccess(image: pickedFile));
    }
  }
}
