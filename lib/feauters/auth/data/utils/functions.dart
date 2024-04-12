import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

Future<http.MultipartRequest> uploadImage(XFile? imageFile, XFile? imageFile2,
    Map<String, dynamic> postData, apiUrl, token) async {
  final url = Uri.parse(apiUrl);
  final mimeType = lookupMimeType(imageFile!.path)!.split('/');
  final mimeType2 = lookupMimeType(imageFile2!.path)!.split('/');
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
  try {
    imageUploadRequest.fields['age'] = postData['age'].toString();
    imageUploadRequest.fields['bio'] = postData['bio'];
    imageUploadRequest.fields['phone_number'] = postData['phone_number'];
    imageUploadRequest.fields['address'] = jsonEncode(postData['address']);
    imageUploadRequest.fields['job_status'] = postData['job_status'];
    imageUploadRequest.fields['gender'] = postData['gender'];
    imageUploadRequest.fields['budget'] = postData['budget'].toString();
    imageUploadRequest.fields['religion'] = postData['religion'];
    imageUploadRequest.fields['pets'] = postData['pets'];
    imageUploadRequest.fields['smoking'] = postData['smoking'];
    imageUploadRequest.fields['privacy'] = postData['privacy'];
    imageUploadRequest.fields['socialize'] = postData['socialize'];
    imageUploadRequest.fields['religious_compatibility'] =
        postData['religious_compatibility'];

    imageUploadRequest.headers['Authorization'] = 'Bearer $token';
  } catch (e) {
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
  final String decoded =
      utf8.decode(base64Url.decode(base64Url.normalize(payload)));
  return json.decode(decoded);
}
