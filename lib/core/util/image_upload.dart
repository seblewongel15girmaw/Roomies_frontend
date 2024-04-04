import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:http/http.dart' as http;
Future<int> uploadImage(XFile imageFile,XFile imageFile2, Map<String, dynamic> postData, apiUrl,token) async {
    final url = Uri.parse(apiUrl);
    print("the url is ${url}");
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
    // imageUploadRequest.fields['age'] = postData['age'].toString();
    imageUploadRequest.fields['bio'] = postData['bio'];
    imageUploadRequest.fields['phone_number'] = postData['phone_number'];
    imageUploadRequest.fields['address'] = postData['address'];
    imageUploadRequest.fields['job_status'] = postData['job_status'];
    imageUploadRequest.fields['gender'] = postData['gender'];
    // imageUploadRequest.fields['budget'] = postData['budget'];
    imageUploadRequest.headers['Authorization'] = 'Bearer $token';}
    catch(e){
      print("some error ${e} occured");
    }
    print("the image upload request is : ${imageUploadRequest}");
    try {
      
      final response = await http.Response.fromStream(await imageUploadRequest.send());
      return response.statusCode;
      
    } catch (e) {
      print("request not send and the error is ${e}");
      return 404;
    }
   }