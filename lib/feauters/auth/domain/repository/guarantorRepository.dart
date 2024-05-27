import 'package:begara_mobile/core/error/errors.dart';
import 'package:begara_mobile/feauters/auth/domain/Entities/location.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

abstract class GuarantorRepo {
  Future<Either<Errors,int>> createGuarantor(String fullName, String phoneNumber, String gender,String image, Location address, XFile idImage );
}