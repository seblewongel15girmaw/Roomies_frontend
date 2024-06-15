import "dart:convert";

import "package:http/http.dart" as http;

import "../../../../../core/util/env.dart";
import "../../../../../core/util/sharedPreference.dart";
import "../../../../auth/data/utils/functions.dart";

abstract class PaymentRemoteDatasource{
  Future<String?> makePayment(String trx_ref);
  Future<String?> checkPaymentStatus(String trx_ref);
}


class PaymentRemoteDatasourceImpl implements PaymentRemoteDatasource{
  var client = http.Client();
  PaymentRemoteDatasourceImpl(this.client);
  var headers = {
    'Authorization': 'Bearer CHASECK_TEST-OkASkO7g15FwXrTIyAtQ6F4YoybiuJQ1',
    'Content-Type': 'application/json'
  };
  static const BASEURL="https://api.chapa.co/v1/transaction";
  @override
  Future<String?> makePayment(String tx_ref) async{
    final token = await SharedPreferencesService.getString("tokens");
    // final userEmail = decodeJwt(token!)["email"];
    // final userPhone = decodeJwt(token)["phoneNumber"];
    // final fullname = decodeJwt(token)["fullName"].split(" ");

    var request = http.Request(
        'POST', Uri.parse('${BASEURL}/initialize'));
    request.body = json.encode({
      "amount": "100",
      "currency": "ETB",
      "email": "email@gmail.com",
      "first_name": "rut",
      "last_name": "last name",
      "phone_number": "0987654321",
      "tx_ref":tx_ref,
      "callback_url": "https://webhook.site/077164d6-29cb-40df-ba29-8a00e59a7e60",
      "return_url": "https://www.google.com/",
      "customization[title]": "Payment for my favourite merchant",
      "customization[description]": "I love online payments"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    // String res = await response.stream.bytesToString();
    // print("this is the payment");
    // print(res);
    if (response.statusCode == 200) {
      String res = await response.stream.bytesToString();
      var jsonResponse = jsonDecode(res);

      // var status= await CheckPaymentStatus(tx_ref);
      // print(status);
      return jsonResponse["data"]["checkout_url"];
    }
    else {
      print(response.reasonPhrase);
      return null;
    }
//   await Future.delayed(Duration(minutes: 2));
  }


  @override
  Future<String?> checkPaymentStatus(String trx_ref) async{
    final token= await SharedPreferencesService.getString("token");
    final userId=decodeJwt(token!)["userId"];

    var requestTrx = http.Request('GET', Uri.parse('${BASEURL}/verify/$trx_ref'));
    requestTrx .body = '''''';
    requestTrx .headers.addAll(headers);

    http.StreamedResponse responseTrx = await requestTrx.send();

    if (responseTrx.statusCode == 200) {
      String res = await responseTrx.stream.bytesToString();
       var jsonResponse= jsonDecode(res);

       if(jsonResponse["data"]["status"]=="success"){
        var res = await client.post(Uri.parse("http://${ipAdress}:3000/api/users/change_payment_status/${userId}"));
        if(res.statusCode==200){
          return "Success";
        }
        else{
          return "error";
        }
       }
      return jsonResponse["data"]["status"];
    }
    else {
      print(responseTrx.reasonPhrase);
      return "";
    }

  }

}