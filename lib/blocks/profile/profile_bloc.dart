import 'dart:async';
import 'dart:convert';
import 'package:begara_mobile/blocks/profile/profile_event.dart';
import 'package:begara_mobile/blocks/profile/profile_state.dart';
import 'package:begara_mobile/blocks/sharedPreference.dart';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;

class ProfileBloc extends Bloc<ProfileEvent,ProfileState>{
  ProfileBloc():super(Idle()){
    on<ProfileEvent>(_createProfileClicked);
  }

  void _createProfileClicked(ProfileEvent event, Emitter emit) async{
    // String? id = await SharedPreferencesService.getString('id');
    // print("the id obtained is ${id}");
    String? token = await SharedPreferencesService.getString('token');

    
  const String uri="http://localhost:3000/api/users/1/profile";
  final Map <String,dynamic> postData= {
  "age":event.age,
  "bio":event.bio,
  "phone_number":event.phoneNumber,
  "address":event.address,
  "job_status":event.jobStatus,
  "gender":event.gender
  };
  emit(Creating());
  try{
    final response= await http.post(Uri.parse(uri),headers: 
    <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(postData),
    );
    if (response.statusCode==200){
      emit(CreateSuccess());
    }
    else {
      print("we are here folks there is definetly a problem");
      emit(CreateFailed());
    }
  }
  catch(error){
    print("the error occured here is ${error}");
    emit(CreateFailed());
  }
  }
}
  