import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:begara_mobile/blocks/profile/profile_event.dart';
import 'package:begara_mobile/blocks/profile/profile_state.dart';
import 'package:begara_mobile/blocks/sharedPreference.dart';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

class ProfileBloc extends Bloc<ProfileEvent,ProfileState>{
  ProfileBloc():super(Idle()){
    on<ProfileEvent>(_createProfileClicked);
  }

   Future<int> uploadImage(XFile imageFile,XFile imageFile2, Map<String, dynamic> postData, apiUrl,token) async {
    final url = Uri.parse(apiUrl);
    final mimeType = lookupMimeType(imageFile.path)!.split('/');
    final mimeType2=lookupMimeType(imageFile2.path)!.split('/');
    print("the file path is ${imageFile.path}");
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
    imageUploadRequest.fields['age'] = postData['age'].toString();
    imageUploadRequest.fields['bio'] = postData['bio'];
    imageUploadRequest.fields['phone_number'] = postData['phone_number'];
    imageUploadRequest.fields['address'] = postData['address'];
    imageUploadRequest.fields['job_status'] = postData['job_status'];
    imageUploadRequest.fields['gender'] = postData['gender'];
    imageUploadRequest.fields['budget'] = postData['budget'];
    imageUploadRequest.headers['Authorization'] = 'Bearer $token';
    try {
      final response = await http.Response.fromStream(await imageUploadRequest.send());
      return response.statusCode;
      
    } catch (e) {
      print("request not send and the error is ${e}");
      return 404;
    }
   }
  void _createProfileClicked(ProfileEvent event, Emitter emit) async{
    XFile imageFile=event.image;
    XFile imageFile2=event.image2;
    int responseCode;
    // String? id = await SharedPreferencesService.getString('id');
    // print("the id obtained is ${id}");
    String? token = await SharedPreferencesService.getString('token');
  const String uri="http://localhost:3000/api/users/1/profile";
  final Map <String,dynamic> postData= {
  "age":event.age,
  "bio":event.bio,
  "phone_number":event.phoneNumber,
  "address":event.address,
  "job_status":event.jobStatus,
  "gender":event.gender,
  "budget":event.budget.toString()
  };
  emit(Creating());
  responseCode=await uploadImage(imageFile,imageFile2, postData, uri, token);

if(responseCode==200){
  emit(CreateSuccess());
}
else{
  print("we are definetly here");
  emit(CreateFailed());
}
  // try{
  //   final response= await http.post(Uri.parse(uri),headers: 
  //   <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       'Authorization': 'Bearer $token'
  //     },
  //     body: jsonEncode(postData),
  //   );
  //   if (response.statusCode==200){
  //     emit(CreateSuccess());
  //   }
  //   else {
  //     print("we are here folks there is definetly a problem");
  //     emit(CreateFailed());
  //   }
  // }
  // catch(error){
  //   print("the error occured here is ${error}");
  //   emit(CreateFailed());
  // }
  }
}
  