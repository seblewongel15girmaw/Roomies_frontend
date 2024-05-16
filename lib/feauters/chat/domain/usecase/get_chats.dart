import 'package:begara_mobile/core/error/errors.dart';
import 'package:begara_mobile/core/usecase/usecase.dart';
import 'package:begara_mobile/feauters/chat/domain/repository/chatRepository.dart';
import 'package:begara_mobile/feauters/chat/presentation/blocs/live_Chat/live_chat_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../entity/chat.dart';

class GetChats implements UseCase<List<Chat>,Params>{
  ChatRepo chatRepo;
  GetChats(this.chatRepo);

  @override
  Future<Either<Errors, List<Chat>>> call(Params param) async {
   return await chatRepo.getChats(param.senderId, param.receiverId);
  }
  
}

class Params extends Equatable{
  int senderId;
  int receiverId;
  Params({required this.senderId, required this.receiverId,});
  
  @override
  // TODO: implement props
  List<Object?> get props => [
    senderId, receiverId
  ];

}