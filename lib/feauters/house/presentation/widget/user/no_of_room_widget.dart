import 'package:flutter/material.dart';

class RoomNumberWidget extends StatelessWidget{
  int noOfRoom;
  VoidCallback onTap;
  RoomNumberWidget({required this.noOfRoom, required this.onTap});

  @override
  Widget build(BuildContext context) {
 return InkWell(
   onTap: onTap,
   child: Container(
     padding:EdgeInsets.symmetric(horizontal: 10, vertical: 1),
     decoration: BoxDecoration(
     color: Colors.grey.shade300,
       borderRadius: BorderRadius.all(Radius.circular(50))
     ),
     child:Text("${noOfRoom.toString()} room")
   ),
 );
  }

}