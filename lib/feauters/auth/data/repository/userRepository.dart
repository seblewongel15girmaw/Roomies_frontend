import 'dart:convert';

import 'package:begara_mobile/core/util/sharedPreference.dart';
import 'package:begara_mobile/core/util/image_upload.dart';
import 'package:begara_mobile/feauters/auth/data/model/user.dart';
import 'package:begara_mobile/feauters/auth/domain/Entities/user.dart';

import 'package:begara_mobile/feauters/auth/domain/repository/userRepository.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../../../core/util/json_decode.dart';


class UserRepoImpl implements UserRepo{
  String baseUri="http://localhost:3000/api/users";
  @override
  Future<int> createProfile(UserEntity user, XFile profileImage, XFile id) async {
    try{
      String? token = await SharedPreferencesService.getString('token');
      print("token is ${token}");
      final apiUrl=baseUri+"/1/profile";
      
      final postData=user.toJson();
      
      final response= await uploadImage(profileImage, id, postData, apiUrl, token);
      print("the response released is ${response}");
      return response;
    }
    catch(e){
      return 404;
    }
    
  }

  @override
  Future<int> createUser(UserEntity user) async{
    try{
    final response= await http.post(Uri.parse(baseUri+"/register"),
    headers: 
    <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        user.toJson()
      ),
    );
    
      return response.statusCode;
    
    }
    catch(error){
      return 404;
    }
  }

  
  @override
  Future<int> loginUser(String userName, String password) async{
    try{
    final response= await http.post(Uri.parse(baseUri+"/login"),
    headers: 
    <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        {"username":userName,
        "password":password}
      ),
    );
    if(response.statusCode==200){
      final jsonResponse = json.decode(response.body);
      final token=jsonResponse['token'];
      print("the token i received is ${token} ");
      Map<String, dynamic> decodedToken = decodeJwt(token);
      final id=decodedToken["userId"];
      SharedPreferencesService.setString("id",id.toString());
      SharedPreferencesService.setString("token",token);
      return response.statusCode;
    }
    else{
      return response.statusCode;
    }
    }
    catch(error){
      return 404;
    }
    
  }}
  
