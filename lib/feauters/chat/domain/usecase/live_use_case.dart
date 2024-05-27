import 'package:begara_mobile/feauters/chat/domain/entity/chat.dart';
import 'package:begara_mobile/feauters/chat/domain/repository/live_repository.dart';

class ConnectUseCase {
  final LiveRepository repository;

  ConnectUseCase(this.repository);

  Future<void> call(int userId, void Function(Chat chat) onMessageReceived) async{
    await repository.connect(userId, onMessageReceived);
  }

  Stream<Chat> get messages{
    return repository.messages;
  }
}

class SendMessageUseCase {
  final LiveRepository repository;

  SendMessageUseCase(this.repository);

  void call(int userId, int receiverId, String message, dynamic time) {
    repository.sendMessage(userId, receiverId, message,time);
  }
}

class DisconnectUseCase {
  final LiveRepository repository;

  DisconnectUseCase(this.repository);

  void call() {
    repository.disconnect();
  }
}