import '../entity/chat.dart';

abstract class LiveRepository {
  Future<void> connect(int userId, void Function(Chat chat) onMessageReceived);
  void sendMessage(int userId, int receiverId, String message,dynamic time);
  void disconnect();
  Stream<Chat> get messages;
}