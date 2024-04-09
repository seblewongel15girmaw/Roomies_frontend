import 'package:begara_mobile/core/error/errors.dart';
import 'package:begara_mobile/feauters/auth/domain/Entities/user.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dartz/dartz.dart';
abstract class UserRepo{
  Future<Either<Errors, int>> createUser(UserEntity user);
  Future<Either<Errors,int>> loginUser(String userName, String password, );
  Future<Either<Errors,int>> createProfile(UserEntity user, XFile profileImage, XFile id);
}