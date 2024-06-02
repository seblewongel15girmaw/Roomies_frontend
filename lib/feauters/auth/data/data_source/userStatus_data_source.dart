import 'dart:convert';

import 'package:begara_mobile/feauters/house/core/error/exception.dart';

import '../model/userStatus.dart';
import "package:http/http.dart" as http;

abstract class UserStatusDataSource{
  Future<UserStatusModel> getUserStatus(String id);
}


class UserStatusDataSourceImpl implements UserStatusDataSource{
  final baseUri = "http://localhost:3000/api/users/";
  final http.Client client;

  UserStatusDataSourceImpl(this.client);

  @override
  Future<UserStatusModel> getUserStatus(String id) async{
    final response= await client.post(
      Uri.parse(baseUri + ""),
      headers: {
    'Content-Type': 'application/json; charset=UTF-8',
    },
      body: jsonEncode({
        "id":id
      }),
    );

    if(response.statusCode==200) {
      return UserStatusModel.fromJson(jsonDecode(response.body));
    }
    else{
      throw ServerException(errorMessage: "error while fetching status");
    }
    }

}