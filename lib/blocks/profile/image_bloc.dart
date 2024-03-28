import 'dart:async';

import 'package:begara_mobile/blocks/profile/image_event.dart';
import 'package:begara_mobile/blocks/profile/image_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ImageBloc extends Bloc<SelectEvent,ImageState> {
  ImageBloc():super(Idle()){
    on<SelectEvent>(selectImageClicked);
  }

  FutureOr<void> selectImageClicked(SelectEvent event, Emitter emit) async{
   final picker = ImagePicker(); 
   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
   if(pickedFile!=null){
   emit(ImageSelected(pickedFile));}
  }
}