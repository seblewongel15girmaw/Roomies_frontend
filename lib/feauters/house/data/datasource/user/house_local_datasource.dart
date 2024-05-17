import 'dart:convert';

import 'package:begara_mobile/feauters/house/core/error/exception.dart';
import 'package:begara_mobile/feauters/house/data/model/house_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CachedSavedHouses{
  Future<List<HouseModel>> getCachedHouse();
  Future<void> cacheFavorite(HouseModel houseModel);
}

class CachedSavedHousesImpl extends CachedSavedHouses{
SharedPreferences sharedPreferences;
CachedSavedHousesImpl({required this.sharedPreferences});

static const CACHED_FAVORITE_HOUSE="CACHED_FAVORITE_HOUSE";

  @override
  Future<void> cacheFavorite(HouseModel houseModel) async {
    sharedPreferences.setString(
        CACHED_FAVORITE_HOUSE,
        jsonEncode(houseModel));
  }

  @override
  Future<List<HouseModel>> getCachedHouse() {
   var jsonString = sharedPreferences.getStringList(CACHED_FAVORITE_HOUSE);
if (jsonString != null){
  return Future.value(jsonString.map(
          (house) {
        return HouseModel.fromJson(jsonDecode(house));
      }
  ).toList());
}
else{
  throw CacheException();
}
  }
}