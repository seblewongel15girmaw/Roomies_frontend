import 'package:begara_mobile/feauters/chat/domain/entity/chat.dart';
import 'package:begara_mobile/feauters/chat/presentation/blocs/chat_history/chat_history.dart';
import 'package:begara_mobile/feauters/chat/presentation/blocs/new_chat/new_chat_bloc.dart';
import 'package:begara_mobile/feauters/chat/presentation/blocs/new_chat/new_chat_event.dart';
import 'package:begara_mobile/feauters/chat/presentation/utils/functions.dart';
import 'package:begara_mobile/feauters/chat/presentation/widgets/chat_widget.dart';
import 'package:begara_mobile/feauters/chat/presentation/widgets/contact_info_widget.dart';
import 'package:begara_mobile/feauters/chat/presentation/widgets/message_express.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class AlternateChatPage extends StatelessWidget {
  final user;
  final userId;
  final ScrollController liveChatScrollController = ScrollController();
  final TextEditingController messageController = TextEditingController();
  final List<dynamic> messages = [];  
  final ValueNotifier<int> _notifier = ValueNotifier<int>(0);
  AlternateChatPage({required this.user, required this.userId});
  
  @override
  Widget build(BuildContext context) {
    
    // Load chat history
    BlocProvider.of<ChatHistoryBloc>(context).add(ChatHistoryEvent(
      currentUserId: userId,
      senderId: userId,
      receiverId: user.id,
      message: "",
      socket: "",
    ));

    // Instantiate socket connection
    BlocProvider.of<InstantiateBloc>(context).add(Init(userId: userId));

    return LayoutBuilder(
      builder: (context,constraints) {
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
              ContactInformation(
                screenSize: constraints,
                user: user,
              ),
          
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    height: constraints.maxHeight*0.85,
                    child: Column(
                      children: [
                        ChatDisplay(
                            user: user,
                            notifier: _notifier,
                            messages: messages,
                            liveChatScrollController: liveChatScrollController,
                            userId: userId,
                            screenSize: constraints),
                            MessageExpress(
                        screenSize: constraints,
                        messageController: messageController,
                        messages: messages,
                        userId: userId,
                        user: user,
                        liveChatScrollController: liveChatScrollController,
                        notifier: _notifier)
                      ],
                    ),
                  ),
                ),
              ),
              
            ],
          ),
        );
      }
    );
  }
}
