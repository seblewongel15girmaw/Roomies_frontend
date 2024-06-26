import 'dart:async';
import 'package:begara_mobile/feauters/auth/presentation/bloc/others/image/image_event.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/others/image/image_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ImageBloc extends Bloc<SelectEvent,ImageState> {
  ImageBloc():super(Idle()){
    on<ProfileClicked>(selectImageClicked);
    on<IdClicked>(selectIDClicked);
  }

  FutureOr<void> selectImageClicked(ProfileClicked event, Emitter emit) async{
   final picker = ImagePicker(); 
   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
   if(pickedFile!=null){
    
   emit(ImageSelected(pickedFile));
  
   }}
  

  FutureOr<void> selectIDClicked(IdClicked event, Emitter emit) async{
    final picker = ImagePicker(); 
   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
   if(pickedFile!=null){
    
   emit(IdSelected(pickedFile));
  
   }

  }
}