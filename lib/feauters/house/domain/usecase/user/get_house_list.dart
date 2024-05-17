import 'package:begara_mobile/feauters/house/data/model/house_model.dart';
import 'package:begara_mobile/feauters/house/domain/repository/user/house_repository.dart';

class GetHouseList {
  final HouseRepository houseRepository;
  const GetHouseList(this.houseRepository);

  Future<List<HouseModel>> call() async{
    return await houseRepository.getHouseList();
  }
}