import 'package:begara_mobile/core/error/errors.dart';
import 'package:dartz/dartz.dart';

abstract class UseCase<Type, Params>{
  Future<Either<Errors,Type>> call(Params param);
}