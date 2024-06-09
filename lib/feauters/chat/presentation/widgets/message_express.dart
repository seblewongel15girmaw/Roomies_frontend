import 'package:begara_mobile/feauters/chat/presentation/blocs/new_chat/new_chat_bloc.dart';
import 'package:begara_mobile/feauters/chat/presentation/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entity/chat.dart';
import '../blocs/new_chat/new_chat_event.dart';

class MessageExpress extends StatelessWidget {
  BoxConstraints screenSize;
  final TextEditingController messageController;
  final List<dynamic> messages;
  final dynamic userId;
  final dynamic user;
  final ValueNotifier<int> notifier;
  final ScrollController liveChatScrollController;
  MessageExpress(
      {required this.screenSize,
      required this.messageController,
      required this.messages,
      required this.userId,
      required this.user,
      required this.liveChatScrollController,
      required this.notifier});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenSize.maxWidth,
      height: screenSize.maxHeight * 0.09,
      color: Color.fromARGB(255, 187, 148, 48),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.all(5),
              child: Icon(Icons.emoji_emotions_sharp, color: Colors.amber.shade100, ),),
          Container(
            height: screenSize.maxHeight * 0.07,
            width: screenSize.maxWidth * 0.8,
            child: TextField(
              controller: messageController,
              decoration: InputDecoration(
                hintText: 'Type something',
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.grey), // Set border color for enabled state
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.white), // Set border color for focused state
                ),
              ),
            ),
          ),
          Expanded(
            child: IconButton(
              key: Key("send_message"),
              onPressed: () {
                if (messageController.text.trim() != "") {
                  messages.add(Chat(
                    senderId: userId,
                    receiverId: user.id,
                    message: messageController.text,
                    time: DateTime.now().toString(),
                  ));
                  notifier.value = messages.length;
                  scrollToBottom(liveChatScrollController);
                  BlocProvider.of<LiveBloc>(context).add(SendLiveEvent(
                      currentUserId: userId,
                      senderId: userId,
                      receiverId: user.id,
                      message: messageController.text,
                      socket: '',
                      time: DateTime.now().toString()));
                  messageController.clear();
                }
              },
              icon: Icon(Icons.send,color: Colors.amber.shade100,),
            ),
          ),
        ],
      ),
    );
  }
}
