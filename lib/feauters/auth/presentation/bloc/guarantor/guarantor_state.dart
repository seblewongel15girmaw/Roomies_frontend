abstract class GuarantorState{}

class Idle extends GuarantorState{}

class Creating extends GuarantorState{}

class CreateFailed extends GuarantorState{
  String? error;
  String? causingImage;
  CreateFailed({ this.error, this.causingImage});
}

class CreateSuccess extends GuarantorState{}