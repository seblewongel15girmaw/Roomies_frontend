abstract class RegisterState{}

class Idle extends RegisterState{}

class Registering extends RegisterState{}

class RegisterSuccess extends RegisterState{}

class RegisterFailed extends RegisterState{}