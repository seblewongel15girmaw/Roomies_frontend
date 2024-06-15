import 'package:begara_mobile/feauters/house/data/datasource/user/house_remote_datasource.dart';
import 'package:begara_mobile/feauters/house/data/model/broker_model.dart';
import 'package:begara_mobile/feauters/house/data/model/house_model.dart';
import 'package:begara_mobile/feauters/house/domain/entity/house_entity.dart';
import 'package:begara_mobile/feauters/house/domain/repository/user/house_repository.dart';

class HouseRepositoryImpl implements HouseRepository{
  HouseRemoteDatasource houseRemoteDatasource;

  HouseRepositoryImpl({required this.houseRemoteDatasource});

  @override
  Future<List<HouseModel>> filterHouse(int numOfRoom) async{
    return houseRemoteDatasource.filterHouse(numOfRoom);
  }

  @override
  Future<List<HouseModel>> getHouseList() async{
    List<HouseModel> houseList=await houseRemoteDatasource.getHouseList();
    // List<HouseModel> houseModelList= houseList.map((house) =>house.toEntity()).toList();
    return houseList;
  }

  @override
  Future<List<HouseModel>> savedHouses() {
    // TODO: implement savedHouses
    throw UnimplementedError();
  }

  @override
  Future<HouseModel> searchHouse(String id) {
    // TODO: implement searchHouse
    throw UnimplementedError();
  }

  @override
  Future<BrokerModel?> getBrokerProfile(String id) async{
   return await houseRemoteDatasource.getBrokerProfile(id);
  }

}