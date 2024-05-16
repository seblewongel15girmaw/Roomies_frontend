import '../entity/chat.dart';

abstract class LiveRepository {
  void connect(int userId, void Function(Chat chat) onMessageReceived);
  void sendMessage(int userId, int receiverId, String message);
  void disconnect();
}