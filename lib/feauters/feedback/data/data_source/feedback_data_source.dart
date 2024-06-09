import 'dart:convert';

import 'package:begara_mobile/core/error/exceptions.dart';
import 'package:http/http.dart' as http;

import '../../../../core/util/sharedPreference.dart';
import '../../../auth/data/utils/functions.dart';

abstract class FeedbackDataSource {
  Future<int> giveFeedback(
      String feedbackMessage, List<String> feedbackCategory, double rating);
}

class FeedbackDataSourceImpl implements FeedbackDataSource {
  final baseUri =  "http://192.168.1.5:3000/api/feedback/";
  final http.Client client;
  FeedbackDataSourceImpl(this.client);
  @override
  Future<int> giveFeedback(
      String feedbackMessage, List<String> feedbackCategory, double rating) async {
    final token = await SharedPreferencesService.getString("tokens");
    final userId = decodeJwt(token!)["userId"];
    final response = await client.post(
      Uri.parse(baseUri + "/add-feedback/$userId"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode({
        "feedback_message": feedbackMessage,
        "feedback_category": feedbackCategory,
        "rating": rating
      }),
    );
    if(response.statusCode==201){
      return response.statusCode;
    }
    else{
      throw ServerExceptions();
    }
  }
}
