import 'package:begara_mobile/core/error/errors.dart';
import 'package:begara_mobile/feauters/auth/domain/Entities/user.dart';
import 'package:begara_mobile/feauters/recommendation/domain/entities/roommates.dart';
import 'package:dartz/dartz.dart';

abstract class RoommateRepository {
  Future<Either<Errors,UserEntity>> getRoomate(int id);
  Future<Either<Errors,List<Roommate>>> getAllRoommates(int id);
}