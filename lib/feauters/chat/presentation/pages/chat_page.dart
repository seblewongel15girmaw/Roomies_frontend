import 'dart:io';
import 'package:begara_mobile/feauters/chat/domain/entity/chat.dart';
import 'package:begara_mobile/feauters/chat/presentation/blocs/chat_history/chat_history.dart';
import 'package:begara_mobile/feauters/chat/presentation/blocs/live_Chat/live_chat_bloc.dart';
import 'package:begara_mobile/feauters/chat/presentation/blocs/live_Chat/live_chat_event.dart';
import 'package:begara_mobile/feauters/chat/presentation/utils/functions.dart';
import 'package:begara_mobile/feauters/chat/presentation/widgets/chat_area.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:begara_mobile/feauters/recommendation/presentation/utils/functions.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final ScrollController liveChatScrollController = ScrollController();
  final ScrollController chatHistoryController = ScrollController();
  final List<dynamic> messages = [];
  final TextEditingController messageController = TextEditingController();
  final user;
  final userId;

  ChatPage({required this.user, required this.userId});

  void initializeSocket(BuildContext context, IO.Socket socket) {
    socket.on('message', (data) {
      // Ensure the context is still valid
      if (context.mounted) {
        // Add received message to BLoC
        Chat chat = Chat(
          senderId: data["senderId"],
          receiverId: data["receiverId"],
          message: data["message"],
          time: DateTime.now(),
        );
        messages.add(chat);
        BlocProvider.of<LiveChatBloc>(context).add(LiveChatEvent(
          currentUserId: userId,
          senderId: data["senderId"],
          receiverId: data['receiverId'],
          message: data['message'],
          socket: socket,
        ));
        scrollToBottom(liveChatScrollController);
      }
    });

    socket.connect();
    socket.emit("start", userId);
  }

  @override
  Widget build(BuildContext context) {
    print("I am being built");

    // Initialize the socket and listen for messages
    final socket = IO.io(' http://192.168.1.5:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    initializeSocket(context, socket);

    // Load chat history
    BlocProvider.of<ChatHistoryBloc>(context).add(ChatHistoryEvent(
      currentUserId: userId,
      senderId: userId,
      receiverId: user.id,
      message: "",
      socket: "",
    ));

    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            color: Color.fromRGBO(255, 253,208,1),
            width: screenSize.width,
            height: screenSize.height * 0.15,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 52,
                    width: 52,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(color: Colors.white, width: 1),
                      image: DecorationImage(
                        image: FileImage(File(user.image)),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 1),
                  Text(
                    capitalize(user.userName),
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          ChatArea(
            chats: messages,
            userId: userId,
            user: user,
            liveChatScrollController: liveChatScrollController,
            screenSize: screenSize,
          ),
          Container(
            height: screenSize.height * 0.09,
            color:Colors.amber[100],
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
                        time: DateTime.now(),
                      ));
                      BlocProvider.of<LiveChatBloc>(context).add(LiveChatEvent(
                        currentUserId: userId,
                        senderId: userId,
                        receiverId: user.id,
                        message: messageController.text,
                        socket: socket,
                      ));
                      messageController.clear();
                    }
                  },
                  icon: Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}