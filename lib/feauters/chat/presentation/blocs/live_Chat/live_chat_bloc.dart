import 'dart:async';
import 'package:begara_mobile/feauters/chat/domain/entity/chat.dart';
import 'package:begara_mobile/feauters/chat/domain/usecase/save_chats.dart';
import 'package:begara_mobile/feauters/chat/presentation/blocs/live_Chat/live_chat_event.dart';
import 'package:begara_mobile/feauters/chat/presentation/blocs/live_Chat/live_chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LiveChatBloc extends Bloc<LiveChatEvent, LiveChatState> {
  SaveChats saveChats;
  LiveChatBloc(this.saveChats) : super(Idle()) {
    on<LiveChatEvent>(_sendMessage);
  }

  FutureOr<void> _sendMessage(LiveChatEvent event, Emitter emit) async {
    emit(DeliveringChat());
    if (event.currentUserId == -1) {
      emit(ChatDeliveredSuccessfuly());
    } else if (event.currentUserId == event.senderId) {
      event.socket.emit("message", {
        "currentUser": event.currentUserId,
        "senderId": event.senderId,
        "receiverId": event.receiverId,
        "message": event.message
      });
      Params param = Params(
          chat: Chat(
              senderId: event.senderId,
              receiverId: event.receiverId,
              message: event.message,
              time: ""));
      final response = await saveChats(param);
      response.fold((l) {
        emit(ChatDeliveryFailed());
      }, (r) => emit(ChatDeliveredSuccessfuly()));
    }

    emit(ChatDeliveredSuccessfuly());
  }
}
