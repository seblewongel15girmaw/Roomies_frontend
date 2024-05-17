import 'dart:io';

import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:begara_mobile/feauters/house/data/model/house_model.dart';
import 'package:begara_mobile/feauters/house/presentation/widget/user/payment_modal.dart';

class HouseDetail extends StatelessWidget{
  late  HouseModel houseModel;
   HouseDetail({super.key, required this.houseModel});

  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
   return Scaffold(
     body: SafeArea(
       child: Container(
         height: height,
         child: Stack(
           children: [
             AnotherCarousel(
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
                 image:FileImage(File(image.imageUrl)),
                 fit: BoxFit.cover,);},
             ).toList()
         ),
            Positioned(
              top: 10,
                left: 10,
                child: IconButton(icon:Icon(Icons.arrow_left), color: Colors.white,
                  onPressed: () { Navigator.of(context).pushNamed("/homePage"); },)) ,
             Positioned(
               bottom: 0,
               left: 0,
               child: Container(
                 width:width,
                 height: height/2,
                 decoration: BoxDecoration(
                   gradient: LinearGradient(
                     begin: Alignment.topCenter,
                     end: Alignment.bottomCenter,
                     colors: [
                       Color.fromRGBO(0, 0, 0,0.2),
                       Color.fromRGBO(0, 0, 0,0.8),
                       Color.fromRGBO(0, 0, 0,0.9),
                       Color.fromRGBO(0, 0, 0,1),
                     ]
                   )
                 ),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     SizedBox(height: 20,),
                     Padding(
                       padding: const EdgeInsets.only(left: 40),
                       child: Row(
                         children: [
                          Icon(Icons.room, color: Colors.white60,),
                           SizedBox(width: 17,),
                           Text(houseModel.location, style: TextStyle(color: Colors.white),),
                         ],
                       ),
                     ),
                     SizedBox(height: 8,),
                     Padding(
                       padding: const EdgeInsets.only(left: 40),
                       child: Row(
                         children: [
                           Icon(Icons.square_foot, color: Colors.white,),
                           SizedBox(width: 17,),
                           Text(houseModel.description, style: TextStyle(color: Colors.white)),
                         ],
                       ),
                     ),
                     SizedBox(height: 8,),
                     Padding(
                       padding: const EdgeInsets.only(left: 36),
                       child: Row(
                         children: [
                           Icon(Icons.monetization_on, color: Colors.green,),
                           SizedBox(width: 17,),
                           Text(houseModel.price.toString(), style: TextStyle(color: Colors.white)),
                         ],
                       ),
                     ),
                     SizedBox(height: 8,),
                     Padding(
                       padding: const EdgeInsets.only(left: 40),
                       child: Row(
                         children: [
                           Icon(Icons.roofing_outlined, color: Colors.red,),
                           SizedBox(width: 17,),
                           Text(houseModel.numberOfRoom.toString(), style: TextStyle(color: Colors.white)),
                         ],
                       ),
                     ),

                     Expanded(
                       child: Align(
                         alignment: Alignment.bottomCenter,
                         child: Padding(
                           padding: const EdgeInsets.only(bottom: 30),
                           child: ElevatedButton(
                             onPressed: (){
                               PaymentModal(context);
                             },
                             child: Text("Contact Broker"), style: ButtonStyle(
                             backgroundColor: MaterialStateProperty.all(Color.fromRGBO(244, 196, 48,0.9)),
                             foregroundColor: MaterialStateProperty.all(Colors.black),
                             textStyle: MaterialStateProperty.all(TextStyle(fontWeight: FontWeight.bold))
                           ),),
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