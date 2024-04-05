

import 'package:begara_mobile/feauters/auth/domain/Entities/user.dart';
import 'package:image_picker/image_picker.dart';

abstract class UserRepo{
  Future<int> createUser(UserEntity user);
  Future<int> loginUser(String userName, String password);
  Future<int> createProfile(UserEntity user, XFile profileImage, XFile id);
}