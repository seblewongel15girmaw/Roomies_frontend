import 'dart:async';
import 'dart:convert';

import 'package:begara_mobile/blocks/register/register_event.dart';
import 'package:begara_mobile/blocks/register/register_state.dart';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;

class RegBloc extends Bloc<RegEvent,RegState>{
  RegBloc():super(NoAttempt()){
    on<RegEvent>(_registerClicked);
  }
 void _registerClicked (RegEvent event, Emitter emit) async {
  final String uri="http://localhost:3000/api/users/register";
  final Map <String,dynamic> postData= {
    "full_name":event.fullName,
    "username":event.userName,
    "email":event.email,
    "password": event.password,
  };

  emit(Registration());
  try{
    final response= await http.post(Uri.parse(uri),headers: 
    <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(postData),
    );
    if (response.statusCode==201){
      emit(Registerd());
    }
    else {
      final jsonResponse = json.decode(response.body);
      final errorMessage = jsonResponse['message'] ?? 'Unknown error';
      emit(NotRegisterd(errorMessage));
    }
  }
  catch(error){
    print("the error occured here is ${error}");
    emit(NotRegisterd("An error has occured"));
  }
  
}
}
