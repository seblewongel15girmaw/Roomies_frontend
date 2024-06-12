abstract class PaymentRepository{
  Future<String?> makePayment(String trx_ref);
  Future<String?> checkPaymentStatus(String trx_ref);
}