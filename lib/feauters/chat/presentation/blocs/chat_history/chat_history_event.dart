class ChatHistoryEvent{
  int currentUserId;
  dynamic socket;
  int senderId;
  int receiverId;
  String message;
  ChatHistoryEvent({required this.currentUserId,required this.senderId, required this.receiverId, required this.message ,required this.socket});
}