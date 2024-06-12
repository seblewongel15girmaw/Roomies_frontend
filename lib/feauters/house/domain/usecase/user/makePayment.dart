import 'package:begara_mobile/feauters/house/domain/repository/user/payment_repository.dart';

class MakePayment{
  PaymentRepository paymentRepository;
  MakePayment(this.paymentRepository);

  Future<String?> call(String trx_ref)async{
    return await paymentRepository.makePayment(trx_ref);
  }
}