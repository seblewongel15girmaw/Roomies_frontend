import 'package:begara_mobile/core/error/errors.dart';
import 'package:begara_mobile/core/usecase/usecase.dart';
import 'package:begara_mobile/feauters/auth/domain/repository/userRepository.dart';
import 'package:dartz/dartz.dart';

class LogOutUser extends UseCase<int,Params>{
  UserRepo userRepo;
  LogOutUser(this.userRepo);

  @override
  Future<Either<Errors, int>> call(Params param) async{
   return await userRepo.logoutUser();
  }
  
}

class Params {

}