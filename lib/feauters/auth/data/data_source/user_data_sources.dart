import 'dart:convert';
import 'package:begara_mobile/core/error/errors.dart';
import 'package:begara_mobile/core/util/sharedPreference.dart';
import 'package:begara_mobile/feauters/auth/domain/Entities/user.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
abstract class UserDataSources {
  Future<int> createUser(UserEntity user);
  Future<String> loginUser(String userName, String password);
  Future<int> createProfile(UserEntity user, XFile profileImage, XFile id);
}

class userDataSourcesImpl implements UserDataSources{
  final http.Client client;

  userDataSourcesImpl(this.client);
  @override
  Future<int> createProfile(UserEntity user, XFile profileImage, XFile id) async{
    final token=await SharedPreferencesService.getString("tokens");
    final userId= decodeJwt(token!)["userId"];

    print("user id is: $userId ");
    final request= await uploadImage(profileImage, id, user.toJson(),
    "http://localhost:3000/api/users/$userId/profile" ,token );
    final response= await client.send(request);
    if (response.statusCode==200){
      return response.statusCode;
    }
    else{
      throw ServerErrors();
    }
  }

  @override
  Future<int> createUser(UserEntity user) async{
    final response=await client.post(Uri.parse("http://localhost:3000/api/users/register"),
     headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body:jsonEncode(user.toJson()),
    );
    if (response.statusCode==201){
      return response.statusCode;
    }
    else{
      throw ServerErrors();
    }
  }

  @override
  Future<String> loginUser(String userName, String password) async{
   final response=await client.post(Uri.parse("http://localhost:3000/api/users/login"), 
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body:jsonEncode( {"username":userName,
        "password":password})
    );

    if (response.statusCode==200){
      final jsonResponse = json.decode(response.body);
      final token=jsonResponse['token'];
      SharedPreferencesService.setString("tokens",token);
      return token;
    }
    else{
      throw ServerErrors();
    }

   
  }

}

Future<http.MultipartRequest> uploadImage(XFile imageFile,XFile imageFile2, Map<String, dynamic> postData, apiUrl,token) async {
    final url = Uri.parse(apiUrl);
    final mimeType = lookupMimeType(imageFile.path)!.split('/');
    final mimeType2=lookupMimeType(imageFile2.path)!.split('/');
    final imageUploadRequest = http.MultipartRequest('POST', url);
    final file = await http.MultipartFile.fromPath(
      'image',
      imageFile.path,
      contentType: MediaType(mimeType[0], mimeType[1]),
    );

    final file2 = await http.MultipartFile.fromPath(
      'personal_id',
      imageFile2.path,
      contentType: MediaType(mimeType2[0], mimeType2[1]),
    );

    // Add image file to the request
    imageUploadRequest.files.add(file);
    imageUploadRequest.files.add(file2);
    // Add existing data to the request body as JSON
    try{
    imageUploadRequest.fields['age'] = postData['age'].toString();
    imageUploadRequest.fields['bio'] = postData['bio'];
    imageUploadRequest.fields['phone_number'] = postData['phone_number'];
    imageUploadRequest.fields['address'] = postData['address'];
    imageUploadRequest.fields['job_status'] = postData['job_status'];
    imageUploadRequest.fields['gender'] = postData['gender'];
    imageUploadRequest.fields['budget'] = postData['budget'].toString();
    imageUploadRequest.headers['Authorization'] = 'Bearer $token';}
    catch(e){
      print("some error ${e} occured");
    }
    print("the image upload request is : ${imageUploadRequest}");
    return imageUploadRequest;
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