abstract class PaymentEvent{}

class MakePaymentEvent extends PaymentEvent{
  String trx_ref;
  MakePaymentEvent(this.trx_ref);
}

class PaymentStatusEvent extends PaymentEvent{
  String trx_ref;
  PaymentStatusEvent(this.trx_ref);
}