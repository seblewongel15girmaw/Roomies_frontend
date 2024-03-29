import 'dart:async';
import 'dart:convert';
import 'package:begara_mobile/blocks/sharedPreference.dart';
import 'package:http/http.dart' as http;
import 'package:begara_mobile/blocks/login/login_event.dart';
import 'package:begara_mobile/blocks/login/login_state.dart';
import 'package:bloc/bloc.dart';

class LogBloc extends Bloc<LogEvent,LogState>{
  LogBloc(): super(Idle()){
    on<LogEvent>(_loginClicked);
  }
Map<String, dynamic> decodeJwt(String token) {
  final parts = token.split('.');
  if (parts.length != 3) {
    throw Exception('Invalid token');
  }
  final payload = parts[1];
  final String decoded = utf8.decode(base64Url.decode(base64Url.normalize(payload)));
  return json.decode(decoded);
}
  void _loginClicked(LogEvent event, Emitter emit) async{
    final String uri="http://localhost:3000/api/users/login";
  final Map <String,dynamic> postData= {
    "username":event.userName,
    "password": event.password,
  };

  emit(Logingin());
  try{
    final response= await http.post(Uri.parse(uri),headers: 
    <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(postData),
    );
    if (response.statusCode==200){
      final jsonResponse = json.decode(response.body);
      // final id= jsonResponse['userId'].toString();
      final token=jsonResponse['token'];
      Map<String, dynamic> decodedToken = decodeJwt(token);
      final id=decodedToken["userId"];
      
      SharedPreferencesService.setString("id",id.toString());
      SharedPreferencesService.setString("token",token);
      
      print("the token is : ${token}");
      emit(LoginSuccess());
    }
    else if(response.statusCode==500){
      print("internal server error");
    }
    else {
      final jsonResponse = json.decode(response.body);
      final errorMessage = jsonResponse['message'] ?? 'Unknown error';
      emit(LoginFailed(errorMessage));
    }
  }
  catch(error){
    print("the error occured here is ${error}");
    emit(LoginFailed("An error has occured"));
  }
  
  }
}