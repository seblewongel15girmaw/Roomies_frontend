import 'dart:io';

import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BrokerDetail extends StatelessWidget{

  BrokerDetail();

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
                    images: [NetworkImage("https://image.cnbcfm.com/api/v1/image/103500764-GettyImages-147205632-2.jpg?v=1691157601")],
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
                              Text("contact is 098765", style: TextStyle(color: Colors.white),),
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
                              Text("mano", style: TextStyle(color: Colors.white)),
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
                              Text("email@gmail.com", style: TextStyle(color: Colors.white)),
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
                              Text("this is nice", style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),

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