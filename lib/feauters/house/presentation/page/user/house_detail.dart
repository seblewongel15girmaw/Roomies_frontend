import 'dart:io';

import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/user_status/user_status_bloc.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/user_status/user_status_event.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/user_status/user_status_state.dart';
import 'package:begara_mobile/feauters/house/presentation/bloc/user/payment/payment_bloc.dart';
import 'package:begara_mobile/feauters/house/presentation/bloc/user/payment/payment_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:begara_mobile/feauters/house/data/model/house_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/util/env.dart';
import '../../bloc/user/payment/payment_state.dart';


class HouseDetail extends StatelessWidget{
  late  HouseModel houseModel;
   HouseDetail({super.key, required this.houseModel});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserStatusBloc>(context).add(ClickEvent());

    var location= houseModel.location.displayName.split("/")[0];
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    BuildContext newContext= context;
   return Scaffold(
     body: SafeArea(
       child: Container(
         height: height,
         child: Stack(
           children: [
             Container(
               decoration: BoxDecoration(
                   borderRadius: BorderRadius.vertical(bottom:Radius.circular(70)),
                   boxShadow: [
                     BoxShadow(
                       color: Colors.grey.shade500,
                       spreadRadius: 1,
                       blurRadius: 3,
                       offset: Offset(0, 3),
                     )
                   ]
               ),
               child: ClipRRect(
                 borderRadius: BorderRadius.vertical(bottom:Radius.circular(70)),
                 child: Container(

                   height: height/1.6,
                   child: AnotherCarousel(
                   boxFit: BoxFit.cover,
                   autoplay: false,
                   animationCurve: Curves.fastOutSlowIn,
                   animationDuration: Duration(milliseconds: 800),
                   dotSize: 4.0,
                   dotIncreasedColor: Color(0xFF7E7E7E),
                   dotBgColor: Colors.transparent,
                   dotPosition: DotPosition.bottomCenter,
                   dotVerticalPadding: 10.0,
                   showIndicator: true,
                   indicatorBgPadding: 7.0,
                   images: houseModel.Images.map((image){
                     return Image(
                       image:NetworkImage("http://${ipAdress}:8000/${image.imageUrl.split("\\").last}"),
                       fit: BoxFit.cover,);},
                   ).toList()
                            ),
                 ),
               ),
             ),
            Positioned(
              top: 0,
                left: 0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(20)),
                    color: Colors.black
                  ),
                  child: IconButton(icon:Icon(Icons.arrow_circle_left_outlined), color: Colors.white,
                    onPressed: () { Navigator.of(context).pushNamed("/homePage"); },),
                )) ,
             Positioned(
               bottom: 0,
               left: 0,
               child: Container(
                 width:width,
                 height: height/2.9,
                 decoration: BoxDecoration(

                 ),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     SizedBox(height: 35,),
                     Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 40),
                       child: Row(
                         children: [
                          Image.asset("asset/map.png", width: 25,),
                           SizedBox(width: 17,),
                           Expanded(child: Text(location, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, ))),
                         ],
                       ),
                     ),
                     SizedBox(height: 8,),
                     Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 40),
                       child: Row(
                         children: [
                           Image.asset("asset/information.png", width: 25,),
                           SizedBox(width: 17,),
                           Expanded(
                               child: Text(houseModel.description,style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, ), )),
                         ],
                       ),
                     ),
                     SizedBox(height: 8,),
                     Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 40),
                       child: Row(
                         children: [
                           Image.asset("asset/money-bag.png", width: 25,),
                           SizedBox(width: 17,),
                           Text('${houseModel.price.toString()} ETB' , style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, ),),
                         ],
                       ),
                     ),
                     SizedBox(height: 8,),
                     Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 40),
                       child: Row(
                         children: [
                           Image.asset("asset/living-room.png", width: 25),
                           SizedBox(width: 17,),
                           Text('${houseModel.numberOfRoom.toString()} rooms ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, ),),
                         ],
                       ),
                     ),
                     Expanded(
                       child: Align(
                         alignment: Alignment.bottomCenter,
                         child: Padding(
                           padding: const EdgeInsets.only(bottom: 30),
                           child: BlocConsumer<UserStatusBloc, UserStatusState>(
                               listener: (context, state) {
                               },
                             builder: (context, state) {
                                   return ElevatedButton(
                                     onPressed: (){
                                       BlocProvider.of<UserStatusBloc>(context).add(ClickEvent());

                                       print("this is house state");
                                       print(state);
                                       if(state is StatusSuccess){
                                         final user= state.user;
                                         if(user.payment_status==1){
                                           Navigator.pushNamed(context, "/brokerProfile");
                                           // return Container();
                                         }
                                         else {
                                       // BlocProvider.of<PaymentBloc>(context).add(PaymentStatusEvent(""));
                                       showModalBottomSheet(
                                           context: newContext,
                                           builder: (_){
                                             return BlocProvider.value(
                                               value: BlocProvider.of<PaymentBloc>(context),
                                               child: BlocListener<PaymentBloc, PaymentState>(
                                                   listener: (context, state) async{
                                                     print("hey");
                                                     print(state);

                                                     if(state is PaymentSuccess){
                                                       String? successUrl = state.successUrl;
                                                       if(successUrl != null){
                                                         var url=Uri.parse(successUrl);
                                                         // if(await canLaunchUrl(url)){
                                                          await launchUrl(url);
                                                         // }
                                                       }
                                                     }
                                                     print("hi");
                                                     if(state is SuccessPaymentStatus){
                                                       Navigator.pushNamed(context, "/brokerProfile");
                                                     }
                                                   },
                                                   child:    Container(
                                                     decoration: BoxDecoration(
                                                         border: Border.all(
                                                             color: Colors.yellow,
                                                             width: 2,
                                                             style: BorderStyle.solid
                                                         ),
                                                         borderRadius: BorderRadius.only(topLeft: Radius.circular(31), topRight:Radius.circular(32) )
                                                     ),
                                                     height: 300,
                                                     width: MediaQuery.of(context).size.width,
                                                     child:Column(
                                                       // mainAxisAlignment: MainAxisAlignment.center,
                                                       crossAxisAlignment: CrossAxisAlignment.center,
                                                       children: [
                                                         SizedBox(height: 60,),
                                                         Text("To view Renter detail ",style:GoogleFonts.pressStart2p(
                                                           fontSize: 9,),),
                                                         SizedBox(height: 20,),
                                                         Text(" please Pay 50 birr fee",style:GoogleFonts.pressStart2p(
                                                           fontSize: 9,)),
                                                         SizedBox(height: 50,),
                                                         ElevatedButton(onPressed: ()async {
                                                           var now = DateTime.now();
                                                           var tx_ref = "chewataatiesit-6669-${now.year}-${now.month}-${now
                                                               .day} ${now.hour}${now.minute}${now.second}";
                                                           BlocProvider.of<PaymentBloc>(context).add(MakePaymentEvent(tx_ref));

                                                           Future.delayed(Duration.zero, () {
                                                             BlocProvider.of<PaymentBloc>(context).add(PaymentStatusEvent(tx_ref));
                                                           });
                                                           BlocListener<PaymentBloc, PaymentState>(
                                                             listener: (context, state) {
                                                               // Check if the payment status event was successful
                                                               if (state is SuccessPaymentStatus) {
                                                                 // Navigate to the other page
                                                                 Navigator.pushNamed(context, "/brokerProfile");
                                                               }
                                                             },
                                                           );
                                                         },
                                                             child: Text("Make Payment")
                                                         )],
                                                     ) ,
                                                   )),
                                             );
                                           });}}
                                       else{
                                         return ;
                                       }},
                                     child: Text("Contact Broker"), style: ButtonStyle(
                                       backgroundColor: MaterialStateProperty.all(Color.fromRGBO(244, 196, 48,0.9)),
                                       foregroundColor: MaterialStateProperty.all(Colors.black),
                                       textStyle: MaterialStateProperty.all(TextStyle(fontWeight: FontWeight.bold))
                                   ),);
                                 }
                           ),
                         ),
                       ),
                     )
                   ],
                 ),
               ),
             )
           ],
         ),
       )
     ),
   );
  }



}