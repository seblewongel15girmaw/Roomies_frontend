import 'package:begara_mobile/feauters/house/data/model/broker_model.dart';
import 'package:begara_mobile/feauters/house/domain/repository/broker/broker_repository.dart';

class GetBroker {
  BrokerRepository brokerRepository;
  GetBroker({required this.brokerRepository});

  Future<BrokerModel> getBroker(String id){
    return brokerRepository.getBroker(id);
  }
}