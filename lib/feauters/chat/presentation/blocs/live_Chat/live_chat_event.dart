class LiveChatEvent{
  int currentUserId;
  dynamic socket;
  int senderId;
  int receiverId;
  String message;
  LiveChatEvent({required this.currentUserId,required this.senderId, required this.receiverId, required this.message ,required this.socket});
}