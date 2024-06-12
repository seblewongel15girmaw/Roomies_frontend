  import 'dart:io';

  import 'package:another_carousel_pro/another_carousel_pro.dart';
  import 'package:flutter/cupertino.dart';
  import 'package:flutter/material.dart';
  import 'package:begara_mobile/feauters/house/data/model/house_model.dart';
  import 'package:flutter/widgets.dart';

import '../../../../../core/util/env.dart';

  class HouseCard extends StatelessWidget{
    HouseModel housemodel;
     HouseCard({super.key, required this.housemodel});

    @override
    Widget build(BuildContext context) {
      var location= housemodel.location.displayName.split("/")[0];
      var height=MediaQuery.of(context).size.height;
      var width=MediaQuery.of(context).size.width;
     return Container(
       margin: EdgeInsets.symmetric(vertical: 30),
       child: Stack(
         clipBehavior: Clip.none,
         children: [
       Container(
       decoration: BoxDecoration(
       color: Colors.white,
           borderRadius:BorderRadius.all(Radius.circular(8)),
           boxShadow: [
             BoxShadow(
               color: Colors.grey.shade300,
               spreadRadius: 1,
               blurRadius: 5,
               offset: Offset(3, 3),
             ),
             BoxShadow(
               color: Colors.grey.shade300,
               spreadRadius: 1,
               blurRadius: 5,
               offset: Offset(-3, -3),
             )
           ]
       ),
        width: width,
         height: 245,
        margin: EdgeInsets.symmetric(vertical: 17, horizontal: 6),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Spacer(),
        Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
        children: [
        Image.asset("asset/map.png", width: 20,),
        SizedBox(width: 17,),
        Expanded(
        child: Text(location, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, ))),],),),
        SizedBox(height: 5,),
        Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
        children: [
        Image.asset("asset/living-room.png", width: 20),
        SizedBox(width: 17,),
        Text('${housemodel.numberOfRoom.toString()} rooms ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, ),),
        ],),),

        SizedBox(height: 10,)
        ],
       ),),

        Positioned(
          top: -50,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                  // borderRadius: BorderRadius.all(Radius.circular(7)),
                  color: Colors.white,
                  borderRadius:BorderRadius.all(Radius.circular(8)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade600,
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(1, 4),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(-2, -2),
                    ),
                  ]
              ),
              child: ClipRRect(
                     borderRadius: BorderRadius.all(Radius.circular(7)),
                     child: Container(
                       decoration: BoxDecoration(
                         border: Border.all(color: Colors.yellow),
                       ),
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
                              return FittedBox(
                                  fit: BoxFit.fill,
                                 child: Image(
                                    image: NetworkImage("http://${ipAdress}:8000/${image.imageUrl.split("\\").last}")),
                                  );
                                },
                           ).toList()
                       ),
                     ),
                   ),
            ),
          ),
        ),
         ]
         ),
     );
    }

  }