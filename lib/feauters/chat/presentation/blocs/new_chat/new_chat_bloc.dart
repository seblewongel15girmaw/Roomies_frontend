import 'dart:async';

import 'package:begara_mobile/feauters/chat/domain/usecase/live_use_case.dart';
import 'package:begara_mobile/feauters/chat/presentation/blocs/new_chat/new_chat_event.dart';
import 'package:begara_mobile/feauters/chat/presentation/blocs/new_chat/new_chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InstantiateBloc extends Bloc<InitializeSocket,InitializeChat>{
  ConnectUseCase connectUseCase;
  InstantiateBloc(this.connectUseCase):super(Initial()){
    on<InitializeSocket>(_initializeSocket);
  }

  FutureOr<void> _initializeSocket(InitializeSocket event, Emitter<InitializeChat> emit) {
    connectUseCase.call(event.userId, (chat) {
      emit(InitializeSuccess(chat: chat));
     });
  }
}

class LiveBloc extends Bloc<SendLiveEvent,SendLive>{
  SendMessageUseCase sendMessageUseCase;
  LiveBloc(this.sendMessageUseCase):super(InitialSend()){
    on<SendLiveEvent>(_sendMessage);
  }

  FutureOr<void> _sendMessage(SendLiveEvent event, Emitter emit) {
    if (event.currentUserId == -1) {
      emit(SendSucess());
    } else if (event.currentUserId == event.senderId) {
      sendMessageUseCase.call(event.currentUserId,event.receiverId,event.message);
      emit(SendSucess());
  }
  }}