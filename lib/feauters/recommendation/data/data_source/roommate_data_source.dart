import 'dart:convert';

import 'package:begara_mobile/core/error/exceptions.dart';
import 'package:begara_mobile/core/util/sharedPreference.dart';
import 'package:begara_mobile/feauters/auth/data/model/user.dart';
import 'package:begara_mobile/feauters/auth/data/utils/functions.dart';
import 'package:begara_mobile/feauters/auth/domain/Entities/user.dart';
import 'package:begara_mobile/feauters/recommendation/data/models/roommate.dart';
import 'package:http/http.dart' as http;
abstract class RoommateDataSource{
  Future<List<RoommateModel>> getAllRoommates(int id);
  Future<UserModel> getRoomate(int id);
}

class RoommateDataSourceImpl implements RoommateDataSource{
  final baseUri= "http://192.168.1.5:3000/api/roommate/";
  final http.Client client;
  RoommateDataSourceImpl(this.client);
  @override
  Future<List<RoommateModel>> getAllRoommates(int id) async{
    final token = await SharedPreferencesService.getString("tokens");
    final userId = decodeJwt(token!)["userId"];
    final response = await client.get(
      Uri.parse(baseUri + "preferenceList/$userId"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode==200){
    List<dynamic> roommates = json.decode(response.body)['preferenceList'];
    
    final potentialRoommates=roommates.map((json) => RoommateModel.fromJson(json)).toList();
    print('the potential roommates are $potentialRoommates');
    return potentialRoommates;}
    else{
      throw ServerExceptions();
    }
    
  }
  
  @override
  Future<UserModel> getRoomate(int id) async{
    final token = await SharedPreferencesService.getString("tokens");
    final userId = decodeJwt(token!)["userId"];
    final response= await client.get(
      Uri.parse( "http://192.168.1.5:3000/api/users/$userId")
    );
    if(response.statusCode==200){
      final userData=json.decode(response.body)["user"];
      
      final user= UserModel.fromJson(userData);
      return user;
    }
    else{
      throw ServerExceptions();
    }
  }

}