import 'package:begara_mobile/core/error/errors.dart';
import 'package:begara_mobile/core/usecase/usecase.dart';
import 'package:begara_mobile/feauters/chat/domain/repository/chatRepository.dart';
import 'package:dartz/dartz.dart';

import '../entity/chat.dart';

class SaveChats extends UseCase<int,Params>{
  ChatRepo chatRepo;
  SaveChats(this.chatRepo);

  @override
  Future<Either<Errors, int>> call(Params param) async{
    return await chatRepo.saveChats(param.chat);
  }
  

}

class Params {
  Chat chat;
  Params({required this.chat});
}