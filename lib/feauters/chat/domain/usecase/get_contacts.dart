import 'package:begara_mobile/core/error/errors.dart';
import 'package:begara_mobile/core/usecase/usecase.dart';
import 'package:begara_mobile/feauters/chat/domain/entity/contacts.dart';
import 'package:begara_mobile/feauters/chat/domain/repository/chatRepository.dart';
import 'package:dartz/dartz.dart';

class GetContacts implements UseCase<List<Contacts>,Params>{
  ChatRepo chatRepo;
  GetContacts(this.chatRepo);

  @override
  Future<Either<Errors, List<Contacts>>> call(Params param) async{
    return await chatRepo.getContacts(param.userId);
  }

}

class Params {
  int userId;
  Params({required this.userId});
}