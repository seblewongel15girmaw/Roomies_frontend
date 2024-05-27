import 'package:begara_mobile/feauters/chat/presentation/blocs/new_chat/new_chat_bloc.dart';
import 'package:begara_mobile/feauters/chat/presentation/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entity/chat.dart';
import '../blocs/new_chat/new_chat_event.dart';

class MessageExpress extends StatelessWidget {
  Size screenSize;
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
      height: screenSize.height * 0.09,
      color: Color.fromARGB(255, 187, 148, 48),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(Icons.emoji_emotions_sharp),
          Container(
            height: screenSize.height * 0.07,
            width: screenSize.width * 0.8,
            child: TextField(
              controller: messageController,
              decoration: InputDecoration(
                hintText: 'Type something',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
          IconButton(
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
            icon: Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
