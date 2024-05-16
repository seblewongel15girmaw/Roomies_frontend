
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';


void scrollToBottom(dynamic controller) {
  if (controller.hasClients) {
    
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      SchedulerBinding.instance!.addPostFrameCallback((_) {
        controller.animateTo(
          controller.position.maxScrollExtent,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      });
    });
  }
  
}

void syncChatHistoryWithLiveChat(
    dynamic chatHisotrycontroller, dynamic liveChatController) {
  if (chatHisotrycontroller.hasClients && liveChatController.hasClients) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      SchedulerBinding.instance!.addPostFrameCallback((_) {
        if (chatHisotrycontroller.offset != liveChatController.offset) {
          if (chatHisotrycontroller.offset > liveChatController.offset) {
            liveChatController.jumpTo(chatHisotrycontroller.offset);
          } else {
            chatHisotrycontroller.jumpTo(liveChatController.offset);
          }
        }
      });
    });
  }
}


String formatTime(){
  return "";
}
