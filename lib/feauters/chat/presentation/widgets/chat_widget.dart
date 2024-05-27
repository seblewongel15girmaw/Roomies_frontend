import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entity/chat.dart';
import '../blocs/chat_history/chat_history.dart';
import '../blocs/new_chat/new_chat_bloc.dart';
import '../utils/functions.dart';

class ChatDisplay extends StatelessWidget {
  final dynamic user;
  final ValueNotifier<int> notifier;
  final List<dynamic> messages;
  final ScrollController liveChatScrollController;
  final dynamic userId;
  final Size screenSize;
  ChatDisplay(
      {required this.notifier,
      required this.messages,
      required this.liveChatScrollController,
      required this.userId,
      required this.user,
      required this.screenSize});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenSize.height * 0.76,
      child: Column(
        children:[ 
          BlocListener<ChatHistoryBloc, ChatHistoryState>(
                  listener: (context, state) {
                    if (state is ChatHistoryLoadedSuccesfuly) {
                      messages.addAll(state.chats);
                      notifier.value = messages.length;
                      scrollToBottom(liveChatScrollController);
                    }
                  },
                  child: SizedBox(height: 0),
                ),
          Expanded(
          child: ValueListenableBuilder<int>(
              valueListenable: notifier,
              builder: (context, value, child) {
                return StreamBuilder<Chat>(
                  stream: BlocProvider.of<InstantiateBloc>(context)
                      .connectUseCase
                      .messages,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && !messages.contains(snapshot.data)) {
                      print("i am on tab of user with id ${user.id} and the received message is for user ${snapshot.data!.receiverId}");
                      if(snapshot.data!.senderId==user.id){
                      messages.add(snapshot.data!);
                      scrollToBottom(liveChatScrollController);}
                    }
                    return ListView.builder(
                      padding: EdgeInsets.only(top: 1),
                      itemCount: messages.length,
                      controller: liveChatScrollController,
                      itemBuilder: (context, int index) {
                        return Align(
                          alignment: messages[index].senderId == userId
                              ? Alignment.centerLeft
                              : Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: screenSize.width * 0.42,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 8.0),
                              decoration: BoxDecoration(
                                color: messages[index].senderId == userId
                                    ? Colors.amber
                                    : Colors.grey,
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(messages[index].message),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        formatTime(messages[index].time, "inchat"),
                                        style: TextStyle(fontSize: 10),
                                      ))
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              }),
        ),]
      ),
    );
  }
}
