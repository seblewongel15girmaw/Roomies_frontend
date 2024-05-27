import 'package:begara_mobile/feauters/chat/data/data_source/live_data_source.dart';
import 'package:begara_mobile/feauters/chat/domain/repository/live_repository.dart';

import '../../domain/entity/chat.dart';

class LiveRepositoryImpl implements LiveRepository {
  final SocketDataProvider dataProvider;

  LiveRepositoryImpl(this.dataProvider);

  @override
  Future<void> connect(int userId, void Function(Chat chat) onMessageReceived) async{
    await dataProvider.connect(userId, );
  }

  @override
  void sendMessage(int userId, int receiverId, String message,dynamic time) {
    dataProvider.sendMessage(userId, receiverId, message,time);
  }

  @override
  void disconnect() {
    dataProvider.disconnect();
  }
  
  @override
  // TODO: implement messages
  Stream<Chat> get messages {
    return dataProvider.messages;
  }
}