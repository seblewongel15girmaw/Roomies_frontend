import 'package:begara_mobile/feauters/house/data/model/broker_model.dart';

abstract class BrokerRepository{
  Future<BrokerModel>getBroker(String id);
}