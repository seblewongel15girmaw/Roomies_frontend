import 'package:begara_mobile/feauters/house/data/model/broker_model.dart';
import "package:http/http.dart" as http;

abstract class BrokerRemoteDataSource{
  Future<BrokerModel> getBrokerDetail(String id);
}


class BrokerRemoteDataSourceImpl extends BrokerRemoteDataSource{
  var client= http.Client();

  BrokerRemoteDataSourceImpl({required this.client});
  @override
  Future<BrokerModel> getBrokerDetail(String id) {
    // TODO: implement getBrokerDetail
    throw UnimplementedError();
  }

}