import 'package:begara_mobile/feauters/auth/domain/Entities/user.dart';
import 'package:flutter/material.dart';

class Profile_fields extends StatelessWidget{
  String title;
  String value;
  Profile_fields({required this.title, required this.value});
  @override
  Widget build(BuildContext context) {
   return Column(
     crossAxisAlignment: CrossAxisAlignment.start,
     children:[
       SizedBox(height: 3,),
       Text(title, style: TextStyle(fontSize: 11, color: Colors.black54),),
       Text(value),
       SizedBox(height: 2,),
       Divider(
         thickness: 2,
         color: Color.fromRGBO(255, 253,208,1),
         height: 1,
       ),
     ] ,
   );
  }

}