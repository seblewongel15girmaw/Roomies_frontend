import 'package:begara_mobile/core/error/errors.dart';
import 'package:begara_mobile/core/usecase/usecase.dart';
import 'package:begara_mobile/feauters/auth/domain/Entities/user.dart';
import 'package:begara_mobile/feauters/auth/domain/usecases/create_profile.dart';
import 'package:begara_mobile/feauters/recommendation/domain/repository/roommate_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetRoommate extends UseCase<UserEntity,Params>{
  RoommateRepository repository;
  GetRoommate(this.repository);
  @override
  Future<Either<Errors, UserEntity>> call(Params param) async{
    return await repository.getRoomate(param.id);
  }
  
}
class Params extends Equatable{
   int id;
  Params({required this.id});
  @override
  // TODO: implement props
  List<Object?> get props => [
    id
  ];
}