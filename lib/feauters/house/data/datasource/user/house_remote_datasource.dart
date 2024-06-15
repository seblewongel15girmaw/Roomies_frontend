import 'package:begara_mobile/core/util/sharedPreference.dart';
import 'package:begara_mobile/feauters/auth/data/utils/functions.dart';
import 'package:begara_mobile/feauters/house/core/error/exception.dart';
import 'package:begara_mobile/feauters/house/data/model/house_model.dart';
import 'package:begara_mobile/feauters/house/domain/entity/broker_entity.dart';
import "package:http/http.dart" as http;
import 'dart:convert';
import 'dart:developer';

import '../../../../../core/util/env.dart';
import '../../model/broker_model.dart';

abstract class HouseRemoteDatasource {
  Future<List<HouseModel>> getHouseList();
  Future<List<HouseModel>> filterHouse(String numOfRoom);
  Future<BrokerModel?> getBrokerProfile(String id);
//   Future<List<HouseModel>> filterHouse(int numOfRoom);
}

class HouseRemoteDatasourceImpl extends HouseRemoteDatasource {
  var client = http.Client();
  static const BASEURL = "http://${ipAdress}:3000/api/";
  HouseRemoteDatasourceImpl({required this.client});

  @override
  Future<List<HouseModel>> getHouseList() async {
    final token = await SharedPreferencesService.getString("tokens");
    final userId = decodeJwt(token!)["userId"];

    try {
      late List<HouseModel> houseModelList;
      var response = await client
          .get(Uri.parse('${BASEURL}houses/getallhouse/${userId}'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      });
      print("the status code is ${response.statusCode}");
      if (response.statusCode == 200) {
        List houseList = jsonDecode(response.body);
        print("this is the house list ${houseList}");
        houseModelList = houseList.map((house) {
          print(house);
          return HouseModel.fromJson(house);
        }).toList();

        return houseModelList;
      } else {
        throw ServerException(errorMessage: "server error");
      }
    } catch (e) {
      log(e.toString());
      return [];
    }
  }


  @override
  Future<List<HouseModel>> filterHouse(String numOfRoom) async{
    final token= await SharedPreferencesService.getString("tokens");
    final userId= decodeJwt(token!)["userId"];

    try{
     var response= await client.post(Uri.parse("${BASEURL}houses/get_all_house_room_based/${userId}"),
     body: jsonEncode({'numberOfRoom': numOfRoom}),);
     List houses =jsonDecode(response.body);
     List<HouseModel> houseList= houses.map((house){
      return HouseModel.fromJson(house);
     }).toList();
return houseList;
   }
   catch(err){
print(err);
return [];
   }
  }

  @override
  Future<BrokerModel?> getBrokerProfile(String id) async{
    try{
      var response = await client.get(Uri.parse(BASEURL+"brokers/getProfile/${id}"));
      print(response.body);
      BrokerModel broker= BrokerModel.fromJson(jsonDecode(response.body));
      return broker;
    }
        catch(err){
      return null;
        }
  }
    //   finally{
    //       client.close();
    // }
  }


//   Future<List<HouseModel>> filterHouse(String numOfRoom) async {
//     final token = await SharedPreferencesService.getString("tokens");
//     final userId = decodeJwt(token!)["userId"];

//     try {
//       var response = await client.post(
//         Uri.parse("${BASEURL}houses/get_all_house_room_based/${userId}"),
//         body: jsonEncode({'numberOfRoom': numOfRoom}),
//       );
//       List houses = jsonDecode(response.body);
//       List<HouseModel> houseList = houses.map((house) {
//         return HouseModel.fromJson(house);
//       }).toList();
//       return houseList;
//     } catch (err) {
//       print(err);
//       return [];
//     }
  }
}
