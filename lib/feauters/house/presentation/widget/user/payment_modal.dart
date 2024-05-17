import 'package:flutter/material.dart';
import 'package:begara_mobile/feauters/house/presentation/page/user/payment_page.dart';
import 'package:url_launcher/url_launcher.dart';

PaymentModal(BuildContext context){
  return showModalBottomSheet(
      context: context,
      builder: (context){
        return Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.yellow,
              width: 1,
              style: BorderStyle.solid
            ),
            color: Colors.black,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight:Radius.circular(20) )
          ),
          height: 250,
          width: MediaQuery.of(context).size.width,
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Pay 50 birr before viewing", style: TextStyle(color: Colors.white),),
              SizedBox(height: 20,),
              ElevatedButton(onPressed: ()async{
                var now=DateTime.now();
                var tx_ref="chewataatiesit-6669-${now.year}-${now.month}-${now.day} ${now.hour}${now.minute}${now.second}";

              String? successUrl = await paymentRequest(tx_ref);
              if(successUrl != null){
                var url=Uri.parse(successUrl);
                if(await canLaunchUrl(url)){
                  launchUrl(url);
                }
                  var status= await CheckPaymentStatus(tx_ref);
                  while (status != "success") {
                  await Future.delayed(Duration(seconds: 20));

                  status = await CheckPaymentStatus(tx_ref);
                  print("in the modal");
                  print(status);
                  }; };},
                  child: Text("Make Payment")
  )
            ],
          ) ,
        );
      });
}