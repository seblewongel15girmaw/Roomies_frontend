import 'package:begara_mobile/core/error/errors.dart';
import 'package:begara_mobile/core/error/exceptions.dart';
import 'package:begara_mobile/core/platform/network_info.dart';
import 'package:begara_mobile/feauters/auth/data/data_source/user_data_sources.dart';
import 'package:begara_mobile/feauters/auth/data/model/user.dart';
import 'package:begara_mobile/feauters/auth/domain/Entities/user.dart';
import 'package:begara_mobile/feauters/recommendation/data/data_source/roommate_data_source.dart';
import 'package:begara_mobile/feauters/recommendation/domain/entities/roommates.dart';
import 'package:begara_mobile/feauters/recommendation/domain/repository/roommate_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class RoommateRepositoryImpl implements RoommateRepository{
  final RoommateDataSource roommateDataSource;
  final Network network;
  RoommateRepositoryImpl(this.roommateDataSource,this.network);
  @override
  Future<Either<Errors, List<Roommate>>> getAllRoommates(int id) async{
    try {
      network.isConnected;
      return Right(
        await roommateDataSource.getAllRoommates(id)
      );
    }
    on ServerExceptions{
      return Left(ServerErrors());
    }
  }

  @override
  Future<Either<Errors, UserEntity>> getRoomate(int id) async{
    try {
      network.isConnected;
      return Right(
        await roommateDataSource.getRoomate(id)
      );
    }
    on ServerExceptions{
      return Left(ServerErrors());
    }
  }

}