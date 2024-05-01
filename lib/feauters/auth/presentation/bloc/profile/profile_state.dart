abstract class ProfileState{}

class Idle extends ProfileState{}

class Creating extends ProfileState{}

class CreateFailed extends ProfileState{
  String? error;
  String? causingImage;
  CreateFailed({ this.error, this.causingImage});
}

class CreateSuccess extends ProfileState{}