import 'package:begara_mobile/core/error/errors.dart';
import 'package:begara_mobile/core/platform/network_info.dart';
import 'package:begara_mobile/feauters/chat/data/data_source/chat_data_source.dart';
import 'package:begara_mobile/feauters/chat/domain/entity/contacts.dart';
import 'package:begara_mobile/feauters/chat/domain/repository/chatRepository.dart';
import 'package:begara_mobile/feauters/chat/presentation/blocs/live_Chat/live_chat_bloc.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/entity/chat.dart';

class ChatRepoImpl extends ChatRepo{
  final ChatDataSources chatDataSources;
  final Network network;
  ChatRepoImpl(this.chatDataSources, this.network);

  @override
  Future<Either<Errors, List<Chat>>> getChats(int senderId, int receiverId) async{
    try {
      network.isConnected;
      return Right(
        await chatDataSources.getChats(senderId,receiverId)
      );
    }
    on ServerExceptions{
      return Left(ServerErrors());
    }
  }
  

  @override
  Future<Either<Errors, List<Contacts>>> getContacts(int userId) async{
   try {
      network.isConnected;
      return Right(
        await chatDataSources.getContacts(userId)
      );
    }
    on ServerExceptions{
      return Left(ServerErrors());
    }
  }

  @override
  Future<Either<Errors, int>> saveChats(Chat chat) async{
   try {
      network.isConnected;
      return Right(
        await chatDataSources.saveChats(chat)
      );
    }
    on ServerExceptions{
      return Left(ServerErrors());
    }
  }
  
  @override
  Future<Either<Errors, dynamic>> initializeSockets() {
    // TODO: implement initializeSockets
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Errors, Chat>> liveReceiveMessage(Chat chat) {
    // TODO: implement liveReceiveMessage
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Errors, Chat>> liveSendMessage(Chat chat) {
    // TODO: implement liveSendMessage
    throw UnimplementedError();
  }
}