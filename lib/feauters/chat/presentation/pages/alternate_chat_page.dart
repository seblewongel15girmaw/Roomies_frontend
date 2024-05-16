import 'dart:io';
import 'package:begara_mobile/feauters/chat/domain/entity/chat.dart';
import 'package:begara_mobile/feauters/chat/presentation/blocs/chat_history/chat_history.dart';
import 'package:begara_mobile/feauters/chat/presentation/blocs/live_Chat/live_chat_bloc.dart';
import 'package:begara_mobile/feauters/chat/presentation/blocs/live_Chat/live_chat_event.dart';
import 'package:begara_mobile/feauters/chat/presentation/blocs/new_chat/new_chat_bloc.dart';
import 'package:begara_mobile/feauters/chat/presentation/blocs/new_chat/new_chat_event.dart';
import 'package:begara_mobile/feauters/chat/presentation/blocs/new_chat/new_chat_state.dart';
import 'package:begara_mobile/feauters/chat/presentation/utils/functions.dart';
import 'package:begara_mobile/feauters/chat/presentation/widgets/chat_area.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:begara_mobile/feauters/recommendation/presentation/utils/functions.dart';
import 'package:flutter/material.dart';

class AlternateChatPage extends StatelessWidget {
  final ScrollController liveChatScrollController = ScrollController();
  final ScrollController chatHistoryController = ScrollController();
  final List<dynamic> messages = [];
  final TextEditingController messageController = TextEditingController();
  final user;
  final userId;

  AlternateChatPage({required this.user, required this.userId});


  @override
  Widget build(BuildContext context) {
    print("I am being built");
    
    

    // Initialize the socket and listen for messages
    

    // Load chat history
    BlocProvider.of<ChatHistoryBloc>(context).add(ChatHistoryEvent(
      currentUserId: userId,
      senderId: userId,
      receiverId: user.id,
      message: "",
      socket: "",
    ));

    BlocProvider.of<InstantiateBloc>(context).add(InitializeSocket(userId: userId));

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
            color: Color.fromARGB(255, 187, 148, 48),
            width: screenSize.width,
            height: screenSize.height * 0.15,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 62,
                    width: 62,
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
          Container(
      height: screenSize.height * 0.76,
      child: Column(
        children: [
          BlocBuilder<InstantiateBloc,InitializeChat>(
            builder: (context,state){
              if(state is InitializeSuccess){
                print("what's up mu ");
              }
              return SizedBox(height: 0,);
          }),
          BlocBuilder<ChatHistoryBloc, ChatHistoryState>(
            builder: (context, state) {
              if (state is ChatHistoryLoadedSuccesfuly) {
                print(" i am alright guys");
                messages.addAll(state.chats);
                BlocProvider.of<LiveBloc>(context).add(SendLiveEvent(
                    currentUserId: -1,
                    senderId: 0,
                    receiverId: 0,
                    message: "",
                    socket: messages.length));
              }
              return SizedBox(
                height: 0,
              );
            },
          ),
          Expanded(
            child: BlocBuilder<LiveBloc, SendLive>(
                builder: (context, state) {
             
              scrollToBottom(liveChatScrollController);
              return state is InitialSend
                  ? Center(
                      child: Text("Say hi to start chating"),
                    )
                  : ListView.builder(
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
                              child: Row(
                                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                children:[
                                Text(messages[index].message),
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
    ),
          Container(
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
                        time: DateTime.now(),
                      ));
                      BlocProvider.of<LiveBloc>(context).add(SendLiveEvent(
                        currentUserId: userId,
                        senderId: userId,
                        receiverId: user.id,
                        message: messageController.text,
                        socket: '',
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