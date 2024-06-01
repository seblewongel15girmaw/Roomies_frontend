import 'package:begara_mobile/core/error/errors.dart';
import 'package:begara_mobile/feauters/auth/domain/Entities/user.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dartz/dartz.dart';

import '../Entities/location.dart';
abstract class UserRepo{
  Future<Either<Errors, int>> createUser(String userName, String fullName, String password, String email );
  Future<Either<Errors,int>> loginUser(String userName, String password, );
  Future<Either<Errors,int>> logoutUser();
  Future<Either<Errors,int>> createProfile(UserEntity user, XFile? profileImage, XFile? id);
  Future<Either<Errors,int>> recoverPassword(String email);
  Future<Either<Errors,int>> changePassword(String oldPassword, String newPassword);
  Future<Either<Errors,List<Location>>> getLocations(String query);
  Future<Either<Errors,int>> unsubscribeUser(String password);

}