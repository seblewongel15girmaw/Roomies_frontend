import 'package:begara_mobile/feauters/house/domain/repository/user/payment_repository.dart';

class CheckPaymentStatus{
  PaymentRepository paymentRepository;
  CheckPaymentStatus(this.paymentRepository);

  Future<String?> call(String trx_ref) async{
   return await paymentRepository.checkPaymentStatus(trx_ref);
  }
}