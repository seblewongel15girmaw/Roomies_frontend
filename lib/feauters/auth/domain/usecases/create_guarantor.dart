import 'package:begara_mobile/core/error/errors.dart';
import 'package:begara_mobile/core/usecase/usecase.dart';
import 'package:begara_mobile/feauters/auth/domain/Entities/guarantor.dart';
import 'package:begara_mobile/feauters/auth/domain/repository/guarantorRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class CreateGuarantor implements UseCase<int,Params>{
  GuarantorRepo guarantorRepo;
  CreateGuarantor(this.guarantorRepo);

  @override
  Future<Either<Errors,int>> call(param) async{
   return await guarantorRepo.createGuarantor(param.fullName, param.phoneNumber, param.gender, param.image, param.address,param.idImage);
  }
  
}

class Params extends Equatable {
  String fullName;
  String phoneNumber;
  String gender;
  String image;
  XFile idImage;
  Map address;
  Params({required this.fullName, required this.phoneNumber, required this.gender,  required this.image, required this.address, required this.idImage});
  
  @override
  // TODO: implement props
  List<Object?> get props {
    return [fullName,phoneNumber,gender,image,address];
  }
  

}