import 'dart:io';

import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:begara_mobile/feauters/house/data/model/house_model.dart';

class HouseCard extends StatelessWidget{
  HouseModel housemodel;
   HouseCard({super.key, required this.housemodel});

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
   return Container(
     decoration: BoxDecoration(
       color: Colors.white,
      borderRadius:BorderRadius.all(Radius.circular(10)),
       boxShadow: [
         BoxShadow(
         color: Colors.grey.shade500,
         spreadRadius: 1,
         blurRadius: 12,
         offset: Offset(3, 3),
       ),
         BoxShadow(
         color: Colors.white,
         spreadRadius: 1,
         blurRadius: 12,
         offset: Offset(-3, -3),
       )]
     ),
     width: width,
     margin: EdgeInsets.symmetric(vertical: 17, horizontal: 6),
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         ClipRRect(
           borderRadius: BorderRadius.all(Radius.circular(10)),
           child: Container(
             decoration: BoxDecoration(
               border: Border.all(color: Colors.yellow),
               boxShadow: [BoxShadow(
                 color: Colors.grey.shade50.withOpacity(0.1),

               )],
             ),
             width: width,
             height: 220,
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
               images: housemodel.Images.map((image){
                    return FittedBox(
                        fit: BoxFit.fill,
                       child: Image(
                          image:FileImage(File(image.imageUrl)),
                        )
                    );
                      },
                 ).toList()
             ),
           ),
         ),
         SizedBox(height: 20,),
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 40),
           child: Row(
             children: [
               Image.asset("asset/map.png", width: 20,),
               SizedBox(width: 17,),
               Text(housemodel.location, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, )),
             ],
           ),
         ),
         SizedBox(height: 5,),
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 40),
           child: Row(
             children: [
               Image.asset("asset/living-room.png", width: 20),
               SizedBox(width: 17,),
               Text('${housemodel.numberOfRoom.toString()} rooms ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, ),),
             ],
           ),
         ),
         Align(
           alignment: Alignment.topRight,
             child: Padding(
               padding: const EdgeInsets.symmetric(horizontal: 20),
               child: Icon(Icons.star_border_outlined),
             )),
         SizedBox(height: 15,)
       ],
     ),
   );
  }


}