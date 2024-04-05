import 'package:begara_mobile/feauters/auth/domain/Entities/user.dart';
import 'package:begara_mobile/feauters/auth/domain/repository/userRepository.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/profile/profile_event.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/profile/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent,ProfileState>{
  UserRepo userRepo;
  ProfileBloc(this.userRepo):super(Idle()){
    on<ProfileEvent>(_createProfileClicked);
  }

  void _createProfileClicked(ProfileEvent event, Emitter emit) async{
    UserEntity user= UserEntity(age: event.age, bio: event.bio, phoneNumber: event.phoneNumber,
    address: event.address, jobStatus: event.jobStatus,gender: event.gender, budget: event.budget 
    );
    final response=await userRepo.createProfile(user,event.image,event.image2);
    emit(Creating());
    if(response==200){
      emit(CreateSuccess());
    }
    else {
      emit(CreateFailed());
    }


  }
}
  