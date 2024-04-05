import 'package:begara_mobile/feauters/auth/presentation/widgets/loginform.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        mainAxisAlignment:MainAxisAlignment.center, 
        children: [
        SizedBox(height: 20,),
        Align(
          alignment: Alignment.topLeft,
          child: GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, "/register");
            },
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight:Radius.circular(25),bottomRight:
               Radius.circular(25)), color: Colors.amber),
              height: 50,
              width: 120,
              
              child: Center(child: Text("Register", style: TextStyle(fontSize: 20, color: Colors.white),)),
            ),
          ),
        ),
        SizedBox(height: 30,),
        Icon(Icons.account_circle,size: 100,color: Colors.amber,),
        LoginForm(),
      ]),
    );
  }


}