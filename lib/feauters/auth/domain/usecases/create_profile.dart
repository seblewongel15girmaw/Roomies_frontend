import 'package:begara_mobile/core/error/errors.dart';
import 'package:begara_mobile/core/usecase/usecase.dart';
import 'package:begara_mobile/feauters/auth/domain/Entities/user.dart';
import 'package:begara_mobile/feauters/auth/domain/repository/userRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class CreateProfile implements UseCase<int, Params>{
  UserRepo repository;
  CreateProfile(this.repository);
  @override
  Future<Either<Errors, int>> call(param) async {
    return await repository.createProfile(param.user,param.profileImage,param.id);
  }

}

class Params extends Equatable{
  UserEntity user;
  XFile profileImage;
  XFile id;
  Params({required this.user, required this.profileImage, required this.id});
  
  @override
  // TODO: implement props
  List<Object?> get props {
    return [user,profileImage,id];
  }

}