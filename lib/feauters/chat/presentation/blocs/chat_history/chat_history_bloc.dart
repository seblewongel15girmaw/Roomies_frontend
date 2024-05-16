import 'dart:async';

import 'package:begara_mobile/feauters/chat/domain/usecase/get_chats.dart';
import 'package:begara_mobile/feauters/chat/presentation/blocs/chat_history/chat_history_event.dart';
import 'package:begara_mobile/feauters/chat/presentation/blocs/chat_history/chat_history_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ChatHistoryBloc extends Bloc<ChatHistoryEvent,ChatHistoryState>{
  GetChats getChats;
  ChatHistoryBloc(this.getChats):super(Initial()){
    on<ChatHistoryEvent>(_loadPreviousChats);

  }

  FutureOr<void> _loadPreviousChats(ChatHistoryEvent event, Emitter emit) async{
    emit(LoadingChatHistory());
    Params param= Params(senderId: event.senderId, receiverId: event.receiverId);
    final response= await getChats(param);
    response.fold((l) {emit(ChatHistoryLoadFailed());
    print("no message found");
    }, (chats) {
      if(chats.isEmpty){
        print("there is notihng here");
        emit(ChatHistoryEmpty());
      }
      else{
        emit(ChatHistoryLoadedSuccesfuly(chats: chats));
      }
    } );
    
  }
}