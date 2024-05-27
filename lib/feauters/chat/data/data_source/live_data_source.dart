import 'dart:async';

import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../domain/entity/chat.dart';

abstract class SocketDataProvider {
  Stream<Chat> get messages;
  Future<void> connect(int userId);
  void sendMessage(int userId, int receiverId, String message,dynamic time);
  void disconnect();
}

class SocketDataProviderImpl extends SocketDataProvider {
  final IO.Socket socket;
  final StreamController<Chat> _messageController = StreamController<Chat>.broadcast();
  SocketDataProviderImpl(this.socket);
  @override
  Stream<Chat> get messages => _messageController.stream;
  Future<void> connect(int userId, ) async{
    
    socket.on('message', (data) {
      Chat chat = Chat(
        senderId: data["senderId"],
        receiverId: data["receiverId"],
        message: data["message"],
        time: data['time'],
      );
     _messageController.add(chat);
    });

    await socket.connect();
    socket.emit("start", userId);
  }
   void dispose() {
    _messageController.close();
  }
  @override
  void sendMessage(int userId, int receiverId, String message,dynamic time) {
    socket.emit('message', {
      'senderId': userId,
      'receiverId': receiverId,
      'message': message,
      'time':time
    });
  }

  @override
  void disconnect() {
    socket.disconnect();
  }
}
