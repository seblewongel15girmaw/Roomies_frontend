
abstract class PaymentState{}

class Idle extends PaymentState{}

class Loading extends PaymentState{}

class PaymentSuccess extends PaymentState{
  final String? successUrl;

  PaymentSuccess(this.successUrl);
}

class SuccessPaymentStatus extends PaymentState{}
class FailedPaymentStatus extends PaymentState{}

class PaymentFailed extends PaymentState{}