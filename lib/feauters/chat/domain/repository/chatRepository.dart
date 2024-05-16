import 'package:begara_mobile/core/error/errors.dart';
import 'package:begara_mobile/feauters/chat/domain/entity/chat.dart';
import 'package:begara_mobile/feauters/chat/domain/entity/contacts.dart';
import 'package:dartz/dartz.dart';

abstract class ChatRepo {
  Future<Either<Errors,List<Chat>>> getChats(int senderId, int receiverId);
  Future<Either<Errors,int>> saveChats(Chat chat);
  Future<Either<Errors,List<Contacts>>> getContacts(int userId);
  

}