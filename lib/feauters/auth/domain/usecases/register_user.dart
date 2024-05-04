import 'package:begara_mobile/core/error/errors.dart';
import 'package:begara_mobile/core/usecase/usecase.dart';
import 'package:begara_mobile/feauters/auth/domain/Entities/user.dart';
import 'package:begara_mobile/feauters/auth/domain/repository/userRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class RegisterUser implements UseCase<int,Params>{
  UserRepo repository;
  RegisterUser(this.repository);
  @override
  Future<Either<Errors, int>> call(param) async{
    return await repository.createUser(param.userName, param.fullName,param.password, param.email);
  }
  
}

class Params extends Equatable{
  String userName;
  String fullName;
  String password;
  String email;
  Params({required this.userName, required this.fullName, required this.password, required this.email});
  
  @override
  // TODO: implement props
  List<Object?> get props {
    return [userName,fullName,password,email];
  }
}