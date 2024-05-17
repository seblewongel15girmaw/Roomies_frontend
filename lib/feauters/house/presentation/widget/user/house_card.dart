import 'dart:io';

import 'package:another_carousel_pro/another_carousel_pro.dart';
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
     ),
     width: width*0.8,
     margin: EdgeInsets.symmetric(vertical: 15, horizontal: 8),
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         ClipRRect(
           borderRadius: BorderRadius.all(Radius.circular(10)),
           child: SizedBox(
             width: width*0.8,
             height: 230,
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
                 print(image.imageUrl);
                    return Image(
                       image:FileImage(File(image.imageUrl)),
                       fit: BoxFit.cover,);},
                 ).toList()

             ),
           ),
         ),
         SizedBox(height: 20,),
         Padding(
           padding: const EdgeInsets.only(left: 20),
           child: Text(housemodel.location, style: TextStyle(fontSize: 13),),
         ),
         Padding(
           padding: const EdgeInsets.only(left: 20),
           child: Text("${housemodel.numberOfRoom} rooms",style: TextStyle(fontSize: 13) ),
         ),
         SizedBox(height: 15,)
       ],
     ),
   );
  }


}