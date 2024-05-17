import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable{
  String message;
  String statusCode;
  Failure({required this.message, required this.statusCode});

  @override
  // TODO: implement props
  List<Object?> get props =>[message, statusCode];

}

class ServerFailure extends Failure{
  ServerFailure({required super.message, required super.statusCode});
}

class LocalCacheFailure extends Failure{
  LocalCacheFailure({required super.message, required super.statusCode});

}