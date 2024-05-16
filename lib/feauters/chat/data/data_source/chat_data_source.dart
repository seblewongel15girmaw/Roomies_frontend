import 'dart:convert';

import 'package:begara_mobile/core/error/exceptions.dart';
import 'package:begara_mobile/feauters/chat/data/model/chat_model.dart';
import 'package:begara_mobile/feauters/chat/data/model/contact_model.dart';
import 'package:begara_mobile/feauters/chat/domain/entity/chat.dart';
import 'package:begara_mobile/feauters/chat/domain/entity/contacts.dart';
import 'package:http/http.dart' as http;

import '../../../../core/util/sharedPreference.dart';
import '../../../auth/data/utils/functions.dart';
abstract class ChatDataSources{
  Future<List<ChatModel>> getChats(int senderId, int receiverId );
  Future<List<ContactsModel>> getContacts( int userId);
  Future<int> saveChats(Chat chat);
}


class ChatDataSourcesImpl implements ChatDataSources{
  final baseUri = "http://localhost:3000/api/chat/";
  final http.Client client;
  
  ChatDataSourcesImpl(this.client);
  @override
  Future<List<ChatModel>> getChats(int senderId, int receiverId) async{
    final token = await SharedPreferencesService.getString("tokens");
    final userId = decodeJwt(token!)["userId"];
    final response=await client.get(Uri.parse(baseUri+"$userId/$receiverId"),
    headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },);
      if(response.statusCode==200){
        List<dynamic> chats= jsonDecode(response.body);
        final userChats= chats.map((json) => ChatModel.fromJson(json)).toList();
        return userChats;
      }
      else{
        throw ServerExceptions();
      }
  }

  @override
  Future<List<ContactsModel>> getContacts(int userId) async{
    print("this is really happening");
    final token = await SharedPreferencesService.getString("tokens");
    final userId = decodeJwt(token!)["userId"];
    final response=await client.get(Uri.parse(baseUri+"$userId"),
    headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },);
    if(response.statusCode==200){
      print("this is the response ${response.body}");
        List<dynamic> contacts= jsonDecode(response.body);
        final userContacts= contacts.map((json) => ContactsModel.fromJson(json)).toList();
        return userContacts;
      }
      else{
        throw ServerExceptions();
      }
  }

  @override
  Future<int> saveChats(Chat chat) async{
    final token = await SharedPreferencesService.getString("tokens");
    final response= await client.post(
      Uri.parse(baseUri),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(chat.toJson())
    );
    if(response.statusCode==201){
      return response.statusCode;
    }
    else{
      throw ServerExceptions();
    }
  }

}