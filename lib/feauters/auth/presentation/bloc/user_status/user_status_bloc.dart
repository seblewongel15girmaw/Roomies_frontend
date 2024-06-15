
import 'package:begara_mobile/feauters/auth/domain/Entities/userStatus.dart';
import 'package:begara_mobile/feauters/auth/domain/usecases/get_user_status.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/user_status/user_status_event.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/user_status/user_status_state.dart';

import 'package:bloc/bloc.dart';

class UserStatusBloc extends Bloc<ClickEvent, UserStatusState>{
  GetUserStatus getUserStatus;
  UserStatusBloc(this.getUserStatus):super(Idle()){
    on<ClickEvent>(load_user);
  }
  Future load_user(ClickEvent event, Emitter emit) async{
    try{
    emit(Idle());
    UserStatusEntity user= await getUserStatus(0.toString());
    emit(StatusSuccess(user));
  }
  catch(e){
print(e);
      emit(StatusFailed());
  }

  }
}