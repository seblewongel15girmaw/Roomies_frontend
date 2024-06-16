
import '../../../data/model/broker_model.dart';
import '../../../data/model/house_model.dart';

abstract class HouseRepository {
  Future<List<HouseModel>> getHouseList();
  Future<HouseModel> searchHouse(String id);
  Future<List<HouseModel>> savedHouses();
  
  Future<List<HouseModel>> filterHouse(int numOfRoom);
  Future<BrokerModel?> getBrokerProfile(String id);
//   Future<List<HouseModel>> filterHouse(int numOfRoom);
}
