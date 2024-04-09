import 'package:begara_mobile/feauters/auth/domain/Entities/user.dart';
import 'package:begara_mobile/feauters/auth/domain/repository/userRepository.dart';
import 'package:begara_mobile/feauters/auth/domain/usecases/create_profile.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/profile/profile_event.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/profile/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent,ProfileState>{
  final CreateProfile createProfile;
  ProfileBloc(this.createProfile):super(Idle()){
    on<ProfileEvent>(_createProfileClicked);
  }

  void _createProfileClicked(ProfileEvent event, Emitter emit) async{
    UserEntity user= UserEntity(age: event.age, bio: event.bio, phoneNumber: event.phoneNumber,
    address: event.address, jobStatus: event.jobStatus,gender: event.gender, budget: event.budget 
    );
    Params params=Params(user: user, profileImage: event.image, id: event.image2);
    final response=await createProfile(params);
    emit(Creating());
    if(response.isRight()){
      emit(CreateSuccess());
    }
    else {
      emit(CreateFailed());
    }


  }
}
  