import 'package:begara_mobile/feauters/recommendation/data/models/roommate.dart';
import 'package:http/http.dart' as http;
abstract class RoommateDataSource{
  Future<List<RoommateModel>> getAllRoommates(int id);
}

class RoommateDataSourceImpl implements RoommateDataSource{
  final baseUri="";
  final http.Client client;
  RoommateDataSourceImpl(this.client);
  @override
  Future<List<RoommateModel>> getAllRoommates(int id) {
    // TODO: implement getAllRoommates
    throw UnimplementedError();
  }

}