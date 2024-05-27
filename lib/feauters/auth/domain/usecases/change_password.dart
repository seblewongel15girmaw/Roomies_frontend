import 'package:begara_mobile/core/error/errors.dart';
import 'package:begara_mobile/core/usecase/usecase.dart';
import 'package:begara_mobile/feauters/auth/domain/repository/userRepository.dart';
import 'package:dartz/dartz.dart';

class ChangePassword implements UseCase<int,Params>{
  final UserRepo userRepo;
  ChangePassword(this.userRepo);
  @override
  Future<Either<Errors, int>> call(Params param) async{
    return await userRepo.changePassword(param.oldPassword,param.newPassword);
  }

}

class Params {
  String oldPassword;
  String newPassword;
  Params({required this.oldPassword,required this.newPassword});
}