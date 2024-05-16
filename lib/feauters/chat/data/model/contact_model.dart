import 'package:begara_mobile/feauters/auth/data/model/user.dart';
import 'package:begara_mobile/feauters/chat/domain/entity/contacts.dart';

class ContactsModel extends Contacts{
  ContactsModel({
    required UserModel user,
    required String lastMessage,
    required dynamic time,
  }):super(lastMessage: lastMessage, user: user , time: time);

  factory ContactsModel.fromJson(Map<String,dynamic> map){
    return ContactsModel(user: UserModel.fromJson(map["profile"]), lastMessage: map["last_message"], time: map["profile"]["createdAt"]);
  }
}