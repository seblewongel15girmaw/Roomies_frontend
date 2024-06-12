
import 'package:begara_mobile/feauters/house/data/datasource/user/payment_remote_datasource.dart';
import 'package:begara_mobile/feauters/house/domain/repository/user/payment_repository.dart';

class PaymentRepositoryImpl implements PaymentRepository{
  PaymentRemoteDatasource paymentRemoteDatasource;

  PaymentRepositoryImpl({required this.paymentRemoteDatasource});

  @override
  Future<String?> checkPaymentStatus(String trx_ref) async{
  String? res= await paymentRemoteDatasource.checkPaymentStatus(trx_ref);
  return res;
  }

  @override
  Future<String?> makePayment(String trx_ref) async{
   String? res= await paymentRemoteDatasource.makePayment(trx_ref);
   return res;
  }

}