abstract class LiveChatState{}

class Idle extends LiveChatState{}

class DeliveringChat extends LiveChatState{}

class ChatDeliveryFailed extends LiveChatState{}

class ChatDeliveredSuccessfuly extends LiveChatState{
  
}