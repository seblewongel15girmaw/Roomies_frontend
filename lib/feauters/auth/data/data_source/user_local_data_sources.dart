import 'package:shared_preferences/shared_preferences.dart';

abstract class UserLocalDataSources {
  Future<void> catchData(String data);
  String? getData(String key);
}

class UserLocalDataSourcesImpl implements UserLocalDataSources{
  final SharedPreferences sharedPreferences;
  UserLocalDataSourcesImpl(this.sharedPreferences);
  @override
  Future<void> catchData(String data) async{
    await sharedPreferences.setString("token", data);
  }

  @override
  String? getData(String key) {
   return sharedPreferences.getString(key);
  }

}