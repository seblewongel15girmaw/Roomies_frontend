import 'dart:convert';
import 'package:begara_mobile/feauters/house/core/error/exception.dart';
import '../../../../core/util/env.dart';
import '../../../../core/util/sharedPreference.dart';
import '../model/userStatus.dart';
import "package:http/http.dart" as http;

import '../utils/functions.dart';

abstract class UserStatusDataSource{
  Future<UserStatusModel> getUserStatus(String id);
}


class UserStatusDataSourceImpl implements UserStatusDataSource{
  final baseUri =  "http://${ipAdress}:3000/api/users/";
  final http.Client client;

  UserStatusDataSourceImpl(this.client);

  @override
  Future<UserStatusModel> getUserStatus(String id) async{
    final token = await SharedPreferencesService.getString("tokens");
    final userId = decodeJwt(token!)["userId"];
    final response= await client.post(
      Uri.parse(baseUri + "getUser_status/${userId}"),
      headers: {
    'Content-Type': 'application/json; charset=UTF-8',
    },
    );

    if(response.statusCode==200) {
      print("this is the status");
      print(jsonDecode(response.body));
      return UserStatusModel.fromJson(jsonDecode(response.body));
    }
    else{
      throw ServerException(errorMessage: "error while fetching status");
    }
    }

}