import 'package:begara_mobile/feauters/auth/domain/Entities/user.dart';
import 'package:equatable/equatable.dart';

class Contacts extends Equatable{
  UserEntity user;
  String lastMessage;
  dynamic time;
  Contacts({required this.user, required this.lastMessage,required this.time});
  
  @override
  // TODO: implement props
  List<Object?> get props => [
    user,
    lastMessage,
    time
  ];

  Map<String,dynamic> toJson(){
    return {
      "user":user,
      "last_message":lastMessage,
      "createdAt":time
    };
  }
}