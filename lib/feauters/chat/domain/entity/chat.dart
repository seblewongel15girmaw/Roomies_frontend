import 'package:equatable/equatable.dart';

class Chat extends Equatable{
  final int senderId;
  final int receiverId;
  final String message;
  final dynamic time;
  const Chat({required this.senderId, required this.receiverId, required this.message, required this.time});
  
  @override
  // TODO: implement props
  List<Object?> get props {
    return [
    senderId,
    receiverId,
    message,
    time,
  ];
  }

  Map<String,dynamic> toJson(){
    return{
      "sender_id":senderId,
      "receiver_id":receiverId,
      "message":message,   
    };
  }
}