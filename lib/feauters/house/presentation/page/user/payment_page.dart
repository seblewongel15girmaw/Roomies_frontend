import "dart:convert";

import "package:http/http.dart" as http;


var headers = {
  'Authorization': 'Bearer CHASECK_TEST-OkASkO7g15FwXrTIyAtQ6F4YoybiuJQ1',
  'Content-Type': 'application/json'
};

Future<String?> paymentRequest(String tx_ref) async {

  var request = http.Request(
      'POST', Uri.parse('https://api.chapa.co/v1/transaction/initialize'));
  request.body = json.encode({
    "amount": "100",
    "currency": "ETB",
    "email": "abebech_bekele@gmail.com",
    "first_name": "Bilen",
    "last_name": "Gizachew",
    "phone_number": "0912345678",
    "tx_ref":tx_ref,
    "callback_url": "https://webhook.site/077164d6-29cb-40df-ba29-8a00e59a7e60",
    "return_url": "https://www.google.com/",
    "customization[title]": "Payment for my favourite merchant",
    "customization[description]": "I love online payments"
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
     String res = await response.stream.bytesToString();
    var jsonResponse = jsonDecode(res);
    print(jsonResponse);
  var status= await CheckPaymentStatus(tx_ref);
print(status);
     return jsonResponse["data"]["checkout_url"];
  }
  else {
    print(response.reasonPhrase);
    return null;
  }
//   await Future.delayed(Duration(minutes: 2));
}


Future<String> CheckPaymentStatus (String tx_ref)async{

  var requestTrx = http.Request('GET', Uri.parse('https://api.chapa.co/v1/transaction/verify/$tx_ref'));
  requestTrx .body = '''''';
  requestTrx .headers.addAll(headers);

  http.StreamedResponse responseTrx = await requestTrx.send();

  if (responseTrx.statusCode == 200) {
    String res = await responseTrx.stream.bytesToString();
    var jsonResponse= jsonDecode(res);
    print(jsonResponse["data"]["status"]);
    return jsonResponse["data"]["status"];
  }
  else {
  print(responseTrx.reasonPhrase);
  return "";
  }

}
