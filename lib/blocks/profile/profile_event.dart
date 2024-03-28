import 'package:image_picker/image_picker.dart';

class ProfileEvent{
  int age;
  String bio;
  String phoneNumber;
  String address;
  String jobStatus;
  String gender;
  XFile image;
  ProfileEvent(this.address,this.bio,this.phoneNumber,this.age,this.jobStatus,this.gender,this.image); 
}