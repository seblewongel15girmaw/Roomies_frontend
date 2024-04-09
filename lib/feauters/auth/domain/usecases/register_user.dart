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
    return await repository.createUser(param.user);
  }
  
}

class Params extends Equatable{
  UserEntity user;
  Params({required this.user});
  
  @override
  // TODO: implement props
  List<Object?> get props {
    return [user];
  }
}