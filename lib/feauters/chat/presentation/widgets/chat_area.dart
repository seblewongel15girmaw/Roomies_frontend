import 'package:begara_mobile/feauters/chat/presentation/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/chat_history/chat_history.dart';
import '../blocs/live_Chat/live_chat.dart';

class ChatArea extends StatelessWidget {
  List<dynamic> chats;
  dynamic userId;
  dynamic user;
  dynamic liveChatScrollController;
  dynamic screenSize;
  ChatArea(
      {required this.chats,
      required this.userId,
      required this.user,
      required this.liveChatScrollController,
      required this.screenSize});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenSize.height * 0.76,
      child: Column(
        children: [
          BlocBuilder<ChatHistoryBloc, ChatHistoryState>(
            builder: (context, state) {
              if (state is ChatHistoryLoadedSuccesfuly) {
                print(" i am alright guys");
                chats.addAll(state.chats);
                BlocProvider.of<LiveChatBloc>(context).add(LiveChatEvent(
                    currentUserId: -1,
                    senderId: 0,
                    receiverId: 0,
                    message: "",
                    socket: chats.length));
              }
              return SizedBox(
                height: 0,
              );
            },
          ),
          Expanded(
            child: BlocBuilder<LiveChatBloc, LiveChatState>(
                builder: (context, state) {
              if(state is ChatHistoryEmpty){
                print("successfuly reached");
              }
              scrollToBottom(liveChatScrollController);
              return state is ChatHistoryEmpty
                  ? Center(
                      child: Text("Say hi to start chating"),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.only(top: 1),
                      itemCount: chats.length,
                      controller: liveChatScrollController,
                      itemBuilder: (context, int index) {
                        return Align(
                          alignment: chats[index].senderId == userId
                              ? Alignment.centerLeft
                              : Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: screenSize.width * 0.42,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 8.0),
                              decoration: BoxDecoration(
                                color: chats[index].senderId == userId
                                    ? Color.fromRGBO(255, 253,208,1)
                                    : Colors.grey[200],
                                borderRadius: BorderRadius.only(topRight:Radius.circular(10), topLeft:Radius.circular(4), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(4)),
                              ),
                              child: Row(
                                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                children:[
                                Text(chats[index].message),
                                // Text(chats[index].time.toString()[0-5], style: TextStyle(fontSize: 10),)
                                ]),
                            ),
                          ),
                        );
                      });
            }),
          ),
        ],
      ),
    );
  }
}
