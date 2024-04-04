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
        Icon(Icons.account_circle,size: 100,color: Colors.amber,),
        LoginForm(),
      ]),
    );
  }


}