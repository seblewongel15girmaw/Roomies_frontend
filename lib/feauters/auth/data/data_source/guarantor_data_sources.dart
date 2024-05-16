import 'package:begara_mobile/core/error/exceptions.dart';
import 'package:begara_mobile/core/util/sharedPreference.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../utils/functions.dart';

abstract class GuarantorDataSource{
  Future<int> createGuarantor(String fullName, String phoneNumber, String gender, String image, XFile idImage, Map address );
}

class GuarantorDataSourceImpl implements GuarantorDataSource{
  final baseUri = "http://localhost:3000/api/guarantors/register/";
  final http.Client client;
  GuarantorDataSourceImpl(this.client);
  @override
  Future<int> createGuarantor(String fullName, String phoneNumber, String gender, String image, XFile idImage, Map address) async{
   final token = await SharedPreferencesService.getString("tokens");
   final userId = decodeJwt(token!)["userId"];
   final request = await uploadSingleImage(idImage, fullName, phoneNumber, gender, address, token, baseUri+"$userId");
  final response = await client.send(request);
    if (response.statusCode == 201) {
      return response.statusCode;
    } else {
      throw ServerExceptions();
    }
  }

} 