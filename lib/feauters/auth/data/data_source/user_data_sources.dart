import 'dart:convert';
import 'package:begara_mobile/core/util/sharedPreference.dart';
import 'package:begara_mobile/feauters/auth/data/utils/functions.dart';
import 'package:begara_mobile/feauters/auth/domain/Entities/user.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../model/location.dart';

abstract class UserDataSources {
  Future<int> createUser(
    String userName, String fullName, String password, String email);
  Future<String> loginUser(String userName, String password);
  Future<int> logoutUser();
  Future<int> createProfile(UserEntity user, XFile? profileImage, XFile? id);
  Future<int> recoverPassword(String email);
  Future<int> changePassword(String oldPassword, String newPassword);
  Future<List<LocationModel>> getLocations(String query);
  Future<int> unsubscribeUser(String password);

}

class userDataSourcesImpl implements UserDataSources {
  final baseUri = "http://localhost:3000/api/users/";
  final http.Client client;

  userDataSourcesImpl(this.client);
  @override
  Future<int> createProfile(
      UserEntity user, XFile? profileImage, XFile? id) async {
    final token = await SharedPreferencesService.getString("tokens");
    final userId = decodeJwt(token!)["userId"];

    print("user id is: $userId ");
    final request = await uploadImage(
        profileImage, id, user.toJson(), baseUri + "$userId/profile", token);
    final response = await client.send(request);
    if (response.statusCode == 200) {
      return response.statusCode;
    } else {
      throw ServerExceptions();
    }
  }

  @override
  Future<int> createUser(
      String userName, String fullName, String password, String email) async {
    final response = await client.post(
      Uri.parse(baseUri + "register"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "full_name": fullName,
        "username": userName,
        "password": password,
        "email": email
      }),
    );
    if (response.statusCode == 201) {
      return response.statusCode;
    } else {
      throw ServerExceptions();
    }
  }

  @override
  Future<String> loginUser(String userName, String password) async {
    final response = await client.post(Uri.parse(baseUri + "login"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({"username": userName, "password": password}));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final token = jsonResponse['token'];
      SharedPreferencesService.setString("tokens", token);
      return token;
    } else {
      throw ServerExceptions();
    }
  }

  @override
  Future<int> recoverPassword(String email) async {
    final response = await client.post(Uri.parse(baseUri + "forget-password"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({"email": email}));
    if (response.statusCode == 201) {
      return response.statusCode;
    } else {
      throw ServerExceptions();
    }
  }
  
  @override
  Future<int> changePassword(String oldPassword, String newPassword) async{
    final token = await SharedPreferencesService.getString("tokens");
    final userId = decodeJwt(token!)["userId"];
    final response= await client.post(Uri.parse(baseUri+"/change-password/$userId"),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    },
    body: jsonEncode({"oldPassword":oldPassword,
            "newPassword":newPassword}),
    );
    if(response.statusCode==200){
      return response.statusCode;
    }
    else{
      throw ServerExceptions();
    }
  }
  
  @override
  Future<List<LocationModel>> getLocations(String query) async{
    final String _baseUrl = 'https://nominatim.openstreetmap.org/search';
   final response = await  client.get(
      Uri.parse('$_baseUrl?q=$query&format=json&addressdetails=1'),
    );

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((item) => LocationModel.fromJson(item)).toList();
    } else {
      throw ServerExceptions();
    }
  }
  
  @override
  Future<int> logoutUser() async{
    dynamic result = await SharedPreferencesService.remove("token");
    if(result==true){
      return 1;
    }
    else{
      throw ServerExceptions();
    }
  }
  
  @override
  Future<int> unsubscribeUser(String password) async {
    final token = await SharedPreferencesService.getString("tokens");
    final userId = decodeJwt(token!)["userId"];
    final response= await client.post(Uri.parse(baseUri+"/recommended_status_change/$userId"),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    },
    body:jsonEncode({"password":password})
    );
    if(response.statusCode==200){
      return response.statusCode;
    }
    else{
      print(response);
      throw ServerExceptions();
    }
  }
  

}
