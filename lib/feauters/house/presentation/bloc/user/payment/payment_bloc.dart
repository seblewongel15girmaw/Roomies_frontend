import 'dart:async';
import 'dart:developer';

import 'package:begara_mobile/feauters/house/domain/usecase/user/checkPaymentStatus.dart';
import 'package:begara_mobile/feauters/house/presentation/bloc/user/payment/payment_event.dart';
import 'package:begara_mobile/feauters/house/presentation/bloc/user/payment/payment_state.dart';
import 'package:bloc/bloc.dart';

import '../../../../domain/usecase/user/makePayment.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState>{
  MakePayment makePayment;
  CheckPaymentStatus checkPaymentStatus;
  PaymentBloc(this.makePayment, this.checkPaymentStatus):super(Idle()){
    on<MakePaymentEvent>(make_payment);
    on<PaymentStatusEvent>(check_payment_status);
  }


  FutureOr<void> make_payment(MakePaymentEvent event, Emitter emit) async{
    emit(Loading());
    try{
      String? successUrl =await makePayment(event.trx_ref);
      print("this is the url");
      print(successUrl);
      emit(PaymentSuccess(successUrl));
    }
    catch(e){
      emit(PaymentFailed());
      log(e.toString());
    }
  }

  FutureOr<void> check_payment_status(PaymentStatusEvent event, Emitter emit) async{
    emit(Idle());
    try{
      var i=0;
      String? status= await checkPaymentStatus(event.trx_ref);
      while (status != "success" && i<8) {
        await Future.delayed(Duration(seconds: 10));
        status= await checkPaymentStatus(event.trx_ref);
        i++;
        print("in the modal");
        print(status);
      }
    if(status=="success"){
      emit(SuccessPaymentStatus());
    }
    else{
      emit(FailedPaymentStatus());
    }
    }
  catch(e){
      print(e);
      emit(FailedPaymentStatus());
  }
    }
  }
