import 'package:begara_mobile/feauters/auth/domain/Entities/guarantor.dart';
import 'package:image_picker/image_picker.dart';

class GuarantorModel extends Guarantor{
  GuarantorModel({
    required String fullName,
    required String phoneNumber,
    required String gender,
    required Map address,
    required String image,
  }):super(address: address, fullName: fullName, gender: gender, image: image, phoneNumber: phoneNumber);
}