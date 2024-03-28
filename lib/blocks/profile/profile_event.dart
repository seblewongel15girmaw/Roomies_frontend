import 'package:image_picker/image_picker.dart';

class ProfileEvent{
  int age;
  String bio;
  String phoneNumber;
  String address;
  String jobStatus;
  String gender;
  int budget;
  XFile image;
  XFile image2;
  ProfileEvent(this.address,this.bio,this.phoneNumber,this.age,this.jobStatus,this.gender,this.image, this.budget,this.image2); 
}