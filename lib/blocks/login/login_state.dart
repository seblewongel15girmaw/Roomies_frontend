abstract class LogState{}

class Idle extends LogState{}

class Logingin extends LogState{}

class LoginFailed extends LogState{
  final String errorMessage;
  LoginFailed(this.errorMessage);
}

class LoginSuccess extends LogState{}