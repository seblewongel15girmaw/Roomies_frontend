import 'package:begara_mobile/core/error/errors.dart';
import 'package:begara_mobile/core/usecase/usecase.dart';
import 'package:begara_mobile/feauters/auth/domain/repository/userRepository.dart';
import 'package:dartz/dartz.dart';

import '../Entities/location.dart';

class GetLocations extends UseCase<List<Location>, Params>{
  UserRepo userRepo;
  GetLocations(this.userRepo);
  @override
  Future<Either<Errors, List<Location>>> call(Params param) async{
    return await userRepo.getLocations(param.query);
  }
  
}

class Params {
  String query;
  Params(this.query);
}