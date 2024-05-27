import 'package:begara_mobile/feauters/auth/domain/Entities/location.dart';
import 'package:image_picker/image_picker.dart';

class ProfileEvent {
  int age;
  String bio;
  String phoneNumber;
  Location address;
  String jobStatus;
  String gender;
  String religion;
  int budget;
  XFile image;
  XFile image2;
  String pet;
  String religiousSimilarity;
  String privacy;
  String socialize;
  String smoking;
  ProfileEvent(
      {required this.address,
      required this.bio,
      required this.phoneNumber,
      required this.age,
      required this.jobStatus,
      required this.gender,
      required this.image,
      required this.budget,
      required this.image2,
      required this.smoking,
      required this.pet,
      required this.privacy,
      required this.religiousSimilarity,
      required this.socialize,
      required this.religion});
}
