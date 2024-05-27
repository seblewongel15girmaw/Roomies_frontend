import '../../../domain/entity/chat.dart';

abstract class InitializeSocket{
}

class Init extends InitializeSocket{
  int userId;
  Init({required this.userId});
}

class ReceiveMessage extends InitializeSocket{
  final Chat chat;
  ReceiveMessage({required this.chat});
}


class SendLiveEvent{
  int currentUserId;
  dynamic socket;
  int senderId;
  int receiverId;
  String message;
  dynamic time;
  SendLiveEvent({required this.currentUserId,required this.senderId, required this.receiverId, required this.message ,required this.socket,required this.time});
}