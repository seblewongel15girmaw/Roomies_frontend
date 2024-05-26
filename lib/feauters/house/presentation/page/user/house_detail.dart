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
             Container(
               height: height/1.63,
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
                   image:FileImage(File(image.imageUrl)),
                   fit: BoxFit.cover,);},
               ).toList()
                        ),
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
                 height: height/2.6,
                 decoration: BoxDecoration(
                   border: Border.all(color: Colors.yellow),

                 ),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     SizedBox(height: 20,),
                     Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 40),
                       child: Row(
                         children: [
                          Image.asset("asset/map.png", width: 25,),
                           SizedBox(width: 17,),
                           Text(houseModel.location, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, )),
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