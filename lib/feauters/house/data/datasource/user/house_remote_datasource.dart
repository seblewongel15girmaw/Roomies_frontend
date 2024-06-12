import 'package:begara_mobile/core/util/sharedPreference.dart';
import 'package:begara_mobile/feauters/auth/data/utils/functions.dart';
import 'package:begara_mobile/feauters/house/core/error/exception.dart';
import 'package:begara_mobile/feauters/house/data/model/house_model.dart';
import "package:http/http.dart" as http;
import 'dart:convert';
import 'dart:developer';

import '../../../../../core/util/env.dart';

abstract class HouseRemoteDatasource{
  Future<List<HouseModel>> getHouseList();
  Future<List<HouseModel>> filterHouse(int numOfRoom);
}

class HouseRemoteDatasourceImpl extends HouseRemoteDatasource{
  var client= http.Client();
  static const BASEURL ="http://${ipAdress}:3000/api/";
  HouseRemoteDatasourceImpl({required this.client});

  @override
  Future<List<HouseModel>> getHouseList() async{
    final token= await SharedPreferencesService.getString("tokens");
    final userId= decodeJwt(token!)["userId"];

    try{
      late List<HouseModel> houseModelList;
      var response= await client.get(Uri.parse('${BASEURL}houses/getallhouse/${userId}'));
      if (response.statusCode==200){
        List houseList= jsonDecode(response.body);
        houseModelList =houseList.map(
                (house) {
                  print(house);
                  return HouseModel.fromJson(house);
                }
        ).toList();

        return houseModelList;
      }  else{
         throw ServerException(errorMessage: "server error");
      }
    }
    catch(e){
      log(e.toString());
      return [];
    }
  //   finally{
  //       client.close();
  // }
  }
  //
  @override
  Future<List<HouseModel>> filterHouse(int numOfRoom) async{
    final token= await SharedPreferencesService.getString("tokens");
    final userId= decodeJwt(token!)["userId"];

    try{
     var response= await client.post(Uri.parse("${BASEURL}houses/get_all_house_room_based/${userId}"),
     body: jsonEncode({'numberOfRoom': numOfRoom }),);
     print("this is the filtered ");
     print(response.body);
     List houses =jsonDecode(response.body);

     List<HouseModel> houseList= houses.map((house){
      return HouseModel.fromJson(house);
     }).toList();
     print(houseList);
return houseList;
   }
   catch(err){
print(err);
return [];
   }
  }
  }
