import 'package:begara_mobile/core/error/errors.dart';
import 'package:begara_mobile/core/error/exceptions.dart';
import 'package:begara_mobile/core/platform/network_info.dart';
import 'package:begara_mobile/feauters/auth/data/data_source/user_data_sources.dart';
import 'package:begara_mobile/feauters/auth/data/data_source/user_local_data_sources.dart';
import 'package:begara_mobile/feauters/auth/domain/Entities/location.dart';
import 'package:begara_mobile/feauters/auth/domain/Entities/user.dart';
import 'package:begara_mobile/feauters/auth/domain/repository/userRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

class UserRepositoryImpl implements UserRepo{
  final UserDataSources userDataSources;
  final UserLocalDataSources userLocalDataSources;
  final Network network;
  UserRepositoryImpl(this.userDataSources, this.userLocalDataSources,this.network);
  @override
  Future<Either<Errors, int>> createProfile(UserEntity user, XFile? profileImage, XFile? id) async {
    try{
    network.isConnected;
    return Right(await userDataSources.createProfile(user, profileImage, id));}
    on ServerExceptions{
      return Left(ServerErrors());
    }
  }

  @override
  Future<Either<Errors, int>> createUser(String userName, String fullName, String password, String email )async {
    try{
    network.isConnected;
    return Right(await userDataSources.createUser(userName,fullName,password,email));}
    on ServerExceptions{
      return Left(ServerErrors());
    } 
  }

  @override
  Future<Either<Errors, int>> loginUser(String userName, String password) async{
    try{
    network.isConnected;
    final response=await userDataSources.loginUser(userName, password);
    userLocalDataSources.catchData(response);
    return Right(200);}
    on ServerExceptions{
      return Left(ServerErrors());
    }
  }
  
  @override
  Future<Either<Errors, int>> recoverPassword(String email) async{
    try{
      network.isConnected;
      return Right(await userDataSources.recoverPassword(email) );
    }
    on ServerExceptions{
      return Left(ServerErrors());
    }
  }
  
  @override
  Future<Either<Errors, int>> changePassword(String oldPassword, String newPassword) async{
    try{
      network.isConnected;
      return Right(await userDataSources.changePassword(oldPassword, newPassword));
    }
    on ServerExceptions{
      return Left(ServerErrors());
    }

  }

  @override
  Future<Either<Errors, List<Location>>> getLocations(String query) async {
    try{
      network.isConnected;
      return Right(await userDataSources.getLocations(query));
    }
    on ServerExceptions{
      return Left(ServerErrors());
    }
  }
  
  @override
  Future<Either<Errors, int>> logoutUser() async{
    try{
      network.isConnected;
      return Right(await userDataSources.logoutUser());
    }
    on ServerExceptions{
      return Left(ServerErrors());
    }
  }
  
  @override
  Future<Either<Errors, int>> unsubscribeUser(String password) async{
    try{
      network.isConnected;
      return Right(await userDataSources.unsubscribeUser(password));
    }
    on ServerExceptions{
      return Left(ServerErrors());
    }
  }
  
}