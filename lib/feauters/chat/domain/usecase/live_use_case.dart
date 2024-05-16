import 'package:begara_mobile/feauters/chat/domain/entity/chat.dart';
import 'package:begara_mobile/feauters/chat/domain/repository/live_repository.dart';

class ConnectUseCase {
  final LiveRepository repository;

  ConnectUseCase(this.repository);

  void call(int userId, void Function(Chat chat) onMessageReceived) {
    repository.connect(userId, onMessageReceived);
  }
}

class SendMessageUseCase {
  final LiveRepository repository;

  SendMessageUseCase(this.repository);

  void call(int userId, int receiverId, String message) {
    repository.sendMessage(userId, receiverId, message);
  }
}

class DisconnectUseCase {
  final LiveRepository repository;

  DisconnectUseCase(this.repository);

  void call() {
    repository.disconnect();
  }
}