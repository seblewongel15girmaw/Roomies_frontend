import 'package:begara_mobile/feauters/house/domain/repository/user/house_repository.dart';

import '../../../data/model/broker_model.dart';

class GetBrokerProfile {
  HouseRepository houseRepository;
  GetBrokerProfile(this.houseRepository);

  Future<BrokerModel?> call(String id) async{
    return await houseRepository.getBrokerProfile(id);
  }

}