class InitializeSocket{
  int userId;
  InitializeSocket({required this.userId});
}
class SendLiveEvent{
  int currentUserId;
  dynamic socket;
  int senderId;
  int receiverId;
  String message;
  SendLiveEvent({required this.currentUserId,required this.senderId, required this.receiverId, required this.message ,required this.socket});
}