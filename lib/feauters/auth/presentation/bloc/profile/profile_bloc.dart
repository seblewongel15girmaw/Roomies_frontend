import 'package:begara_mobile/core/util/locations.dart';
import 'package:begara_mobile/feauters/auth/domain/Entities/user.dart';
import 'package:begara_mobile/feauters/auth/domain/usecases/create_profile.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/profile/profile_event.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/profile/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final CreateProfile createProfile;
  ProfileBloc(this.createProfile) : super(Idle()) {
    on<ProfileEvent>(_createProfileClicked);
  }

  void _createProfileClicked(ProfileEvent event, Emitter emit) async {
    emit(Creating());
    if(event.image==null){
      emit(CreateFailed(error: "please upload a profile pic ",causingImage: "image"));
    }else if(event.image2==null){
      emit(CreateFailed(error: "please upload your id ",causingImage: "image2"));
    }
else{
    int? index= coordinates[event.address];
    int realIndex= index??-1;
    UserEntity user = UserEntity(
      id: 0,
        fullName: "",
        userName: "",
        password: "",
        email: "",
        image2: "",
        image: "",
        age: event.age,
        bio: event.bio,
        phoneNumber: event.phoneNumber,
        address: event.address,
        jobStatus: event.jobStatus,
        religion: event.religion,
        gender: event.gender,
        budget: event.budget,
        pet: event.pet,
        privacy: event.privacy,
        religiousSimilarity: event.religiousSimilarity,
        socialize: event.socialize,
        smoking: event.smoking, profileStatus: 1, activateStatus: 1);
    Params params =
        Params(user: user, profileImage: event.image, id: event.image2);
    final response = await createProfile(params);
    
    if (response.isRight()) {
      emit(CreateSuccess());
    } else {
      emit(CreateFailed());
    }
  }
}
}