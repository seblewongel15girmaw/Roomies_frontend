import 'package:image_picker/image_picker.dart';

class ProfileEvent{
  int? age;
  String? bio;
  String? phoneNumber;
  String? address;
  String? jobStatus;
  String? gender;
  String? religion;
  int? budget;
  XFile? image;
  XFile? image2;
  String? pet ;
  String? religiousSimilarity;
  String? privacy;
  String? socialize;
  String? smoking;
  ProfileEvent({this.address,this.bio,this.phoneNumber,this.age,this.jobStatus,this.gender,this.image, this.budget,this.image2,
                this.smoking, this.pet, this.privacy, this.religiousSimilarity, this.socialize, this.religion}); 
}