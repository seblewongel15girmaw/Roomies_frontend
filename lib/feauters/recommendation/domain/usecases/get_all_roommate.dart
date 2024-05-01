import 'package:begara_mobile/core/error/errors.dart';
import 'package:begara_mobile/core/usecase/usecase.dart';
import 'package:begara_mobile/feauters/recommendation/domain/repository/roommate_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetAllRoommates extends UseCase<List,Params>{
  RoommateRepository repository;
  GetAllRoommates(this.repository);
  Future<Either<Errors, List>> call(param) async{
    return await repository.getAllRoommates(param.id);
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