

import 'package:begara_mobile/feauters/chat/domain/entity/chat.dart';

class ChatModel extends Chat {
  const ChatModel({
    required int senderId,
    required int receiverId,
    required String message,
    required dynamic time,
  }) : super(senderId: senderId, receiverId: receiverId, message: message, time: time);
  factory ChatModel.fromJson(Map<String,dynamic>map){
    return ChatModel(senderId: map["sender_id"], receiverId: map["receiver_id"], message: map["message"], time: map["createdAt"]);
  }
}