import 'package:begara_mobile/feauters/chat/domain/entity/chat.dart';

abstract class ChatHistoryState{}

class Initial extends ChatHistoryState{}

class LoadingChatHistory extends ChatHistoryState{}

class ChatHistoryLoadFailed extends ChatHistoryState{}

class ChatHistoryEmpty extends ChatHistoryState{}

class ChatHistoryLoadedSuccesfuly extends ChatHistoryState{
  List<Chat> chats;
  ChatHistoryLoadedSuccesfuly({required this.chats}); 
}