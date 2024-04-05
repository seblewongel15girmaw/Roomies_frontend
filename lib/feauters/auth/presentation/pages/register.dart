import 'package:begara_mobile/feauters/auth/presentation/widgets/registerform.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment:MainAxisAlignment.center, 
          children: [
          SizedBox(height: 35,),
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, "/login");
              },
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft:Radius.circular(25),bottomLeft:
                 Radius.circular(25)), color: Colors.amber),
                height: 50,
                width: 120,
                
                child: Center(child: Text("Log in", style: TextStyle(fontSize: 20, color: Colors.white),)),
              ),
            ),
          ),
          SizedBox(height: 15,),
          Icon(Icons.account_circle,size: 100,color: Colors.amber,),
          RegisterForm(),
        ]),
      ),
    );
  }

}