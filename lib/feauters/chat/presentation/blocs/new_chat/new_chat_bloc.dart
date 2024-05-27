import 'dart:async';

import 'package:begara_mobile/feauters/chat/domain/entity/chat.dart';
import 'package:begara_mobile/feauters/chat/domain/usecase/live_use_case.dart';
import 'package:begara_mobile/feauters/chat/domain/usecase/save_chats.dart';
import 'package:begara_mobile/feauters/chat/presentation/blocs/new_chat/new_chat_event.dart';
import 'package:begara_mobile/feauters/chat/presentation/blocs/new_chat/new_chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InstantiateBloc extends Bloc<InitializeSocket,InitializeChat>{
  ConnectUseCase connectUseCase;
  StreamSubscription<Chat>? _subscription;
  InstantiateBloc(this.connectUseCase):super(Initial()){
    on<InitializeSocket>(_initializeSocket);
  }

  FutureOr<void> _initializeSocket(InitializeSocket event, Emitter<InitializeChat> emit) async{
    if(event is Init){
    await connectUseCase.call(event.userId, (chat) { });
    }
     _subscription = connectUseCase.messages.listen((chat) {
      add(ReceiveMessage(chat:chat));
    });
    // dynamic receivedMessage;
    // print("hi");
    // await connectUseCase.call(event.userId, (chat) {
    //   receivedMessage=chat;
    //   print("i am receiving this message $chat");
    //   emit(InitializeSuccess(chat:receivedMessage));
    //  });
    //  print("hello");
     
  }
}

class LiveBloc extends Bloc<SendLiveEvent,SendLive>{
  SaveChats saveChats;
  SendMessageUseCase sendMessageUseCase;
  LiveBloc(this.sendMessageUseCase, this.saveChats):super(InitialSend()){
    on<SendLiveEvent>(_sendMessage);
  }

  FutureOr<void> _sendMessage(SendLiveEvent event, Emitter emit) async{
    if (event.currentUserId == -1) {
      emit(SendSucess());
    } else if (event.currentUserId == event.senderId) {
      sendMessageUseCase.call(event.currentUserId,event.receiverId,event.message,event.time);
      Params param = Params(
          chat: Chat(
              senderId: event.senderId,
              receiverId: event.receiverId,
              message: event.message,
              time: ""));
      final response = await saveChats(param);
      response.fold((l) {
        emit(SendSucess());
      }, (r) => emit(SendSucess()));
    }
      emit(SendSucess());
  }
  }