import '../../../domain/entity/chat.dart';

abstract class InitializeChat{}
class Initial extends InitializeChat{}
class InitializeSuccess extends InitializeChat{
  Chat chat;
  InitializeSuccess({required this.chat});
  
}
abstract class SendLive{}
class InitialSend extends SendLive{}
class SendSucess extends SendLive{}
