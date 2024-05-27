import 'package:image_picker/image_picker.dart';

import '../../../domain/Entities/location.dart';

class GuarantorEvent{
  String fullName;
  String phoneNumber;
  Location address;
  String gender;
  XFile profileImage;
  GuarantorEvent({required this.fullName, required this.phoneNumber, required this.address, required this.gender, required this.profileImage});
}