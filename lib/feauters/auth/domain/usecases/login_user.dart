import 'package:begara_mobile/core/error/errors.dart';
import 'package:begara_mobile/core/usecase/usecase.dart';
import 'package:begara_mobile/feauters/auth/domain/repository/userRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class LoginUser implements UseCase<int,Params> {
  UserRepo repository;
  LoginUser(this.repository);
  @override
  Future<Either<Errors,int>>call(Params params) async{
    return await repository.loginUser(params.username, params.password);
  }
}

class Params extends Equatable{
  String username;
  String password;
  Params({required this.username, required this.password});
  
  @override
  // TODO: implement props
  List<Object?> get props {
    return [username, password];
  }
}