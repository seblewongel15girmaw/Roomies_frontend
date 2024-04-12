import 'dart:convert';
import 'package:begara_mobile/core/error/errors.dart';
import 'package:begara_mobile/core/util/sharedPreference.dart';
import 'package:begara_mobile/feauters/auth/data/utils/functions.dart';
import 'package:begara_mobile/feauters/auth/domain/Entities/user.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

abstract class UserDataSources {
  Future<int> createUser(UserEntity user);
  Future<String> loginUser(String userName, String password);
  Future<int> createProfile(UserEntity user, XFile? profileImage, XFile? id);
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
      throw ServerErrors();
    }
  }

  @override
  Future<int> createUser(UserEntity user) async {
    final response = await client.post(
      Uri.parse(baseUri + "register"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );
    if (response.statusCode == 201) {
      return response.statusCode;
    } else {
      throw ServerErrors();
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
      throw ServerErrors();
    }
  }
}
