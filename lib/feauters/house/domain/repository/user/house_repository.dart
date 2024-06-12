
import '../../../data/model/house_model.dart';

abstract class HouseRepository {
  Future<List<HouseModel>> getHouseList();
  Future<HouseModel> searchHouse(String id);
  Future<List<HouseModel>> savedHouses();
  Future<List<HouseModel>> filterHouse(String numOfRoom);
}
