import 'package:begara_mobile/feauters/chat/data/data_source/live_data_source.dart';
import 'package:begara_mobile/feauters/chat/domain/repository/live_repository.dart';

import '../../domain/entity/chat.dart';

class LiveRepositoryImpl implements LiveRepository {
  final SocketDataProvider dataProvider;

  LiveRepositoryImpl(this.dataProvider);

  @override
  void connect(int userId, void Function(Chat chat) onMessageReceived) {
    dataProvider.connect(userId, onMessageReceived);
  }

  @override
  void sendMessage(int userId, int receiverId, String message) {
    dataProvider.sendMessage(userId, receiverId, message);
  }

  @override
  void disconnect() {
    dataProvider.disconnect();
  }
}