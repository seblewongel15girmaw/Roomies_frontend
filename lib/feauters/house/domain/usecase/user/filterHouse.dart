
import 'package:begara_mobile/feauters/house/domain/repository/user/house_repository.dart';

import '../../../data/model/house_model.dart';

class FilterHouse{
  HouseRepository houseRepository;
  FilterHouse(this.houseRepository);

  Future<List<HouseModel>> call (int numOfRoom) async{
   return await houseRepository.filterHouse(numOfRoom);
  }
}