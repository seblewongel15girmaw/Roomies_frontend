import 'dart:async';

import 'package:begara_mobile/feauters/auth/domain/usecases/create_guarantor.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/guarantor/guarantor_event.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/guarantor/guarantor_state.dart';
import 'package:bloc/bloc.dart';

import '../../../../../core/util/locations.dart';

class GuarantorBloc extends Bloc<GuarantorEvent, GuarantorState> {
  final CreateGuarantor createGuarantor;
  GuarantorBloc(this.createGuarantor) : super(Idle()) {
    on<GuarantorEvent>(_createGuarantor);
  }

  FutureOr<void> _createGuarantor(GuarantorEvent event, Emitter emit) async{
    emit(Creating());
    if (event.profileImage == null) {
      emit(
          CreateFailed(error: "Please upload your id", causingImage: "image2"));
    } else {
      int? index = coordinates[event.address];
      int realIndex = index ?? -1;
      Params param = Params(
          fullName: event.fullName,
          phoneNumber: event.phoneNumber,
          gender: event.gender,
          image: event.profileImage.path,
          address: event.address,
          idImage: event.profileImage);
      final response = await createGuarantor(param);
      if (response.isRight()) {
      emit(CreateSuccess());
    } else {
      emit(CreateFailed());
    }
    }
  }
}
