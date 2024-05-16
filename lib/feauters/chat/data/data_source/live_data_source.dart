import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../domain/entity/chat.dart';

abstract class SocketDataProvider {
  void connect(int userId, void Function(Chat chat) onMessageReceived);
  void sendMessage(int userId, int receiverId, String message);
  void disconnect();
}

class SocketDataProviderImpl extends SocketDataProvider {
  final IO.Socket socket;
  SocketDataProviderImpl(this.socket);
  @override
  void connect(int userId, void Function(Chat chat) onMessageReceived) {
    
    socket.on('message', (data) {
      Chat chat = Chat(
        senderId: data["senderId"],
        receiverId: data["receiverId"],
        message: data["message"],
        time: "",
      );
      onMessageReceived(chat);
    });

    socket.connect();
    socket.emit("start", userId);
  }

  @override
  void sendMessage(int userId, int receiverId, String message) {
    socket.emit('message', {
      'senderId': userId,
      'receiverId': receiverId,
      'message': message,
    });
  }

  @override
  void disconnect() {
    socket.disconnect();
  }
}
