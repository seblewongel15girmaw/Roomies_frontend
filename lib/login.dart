import 'package:begara_mobile/blocks/login/login_bloc.dart';
import 'package:begara_mobile/blocks/login/login_event.dart';
import 'package:begara_mobile/blocks/login/login_state.dart';
import 'package:begara_mobile/blocks/profile/profile_bloc.dart';
import 'package:begara_mobile/blocks/register/register_bloc.dart';
import 'package:begara_mobile/blocks/register/register_event.dart';
import 'package:begara_mobile/blocks/register/register_state.dart';
import 'package:begara_mobile/profile.dart';
import 'package:begara_mobile/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    TextEditingController full_name=TextEditingController();
    TextEditingController user_name=TextEditingController();
    TextEditingController email=TextEditingController();
    TextEditingController password=TextEditingController();
    TextEditingController repassword=TextEditingController();


   return Scaffold(
    backgroundColor: Colors.black,
    body: BlocBuilder<LogBloc,LogState> (
      builder: (context,state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 80,
             ),
             Align(
              alignment: Alignment.topLeft,
               child: GestureDetector(
                onTap: (){
                   Navigator.of(context).push(
  MaterialPageRoute<Register>(
    builder: (context) {
   return  BlocProvider<RegBloc>(
            create: (context) => RegBloc(),
        child: Register(),
      );}));
                },
                 child: Container(
                  height: 40,
                  width: 110,
                  decoration: BoxDecoration(color: Color.fromARGB(255, 187, 148, 48),borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20)
                  )),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Register",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black
                      ),
                    ),
                  ),
                 ),
               ),
             ),
             SizedBox(
              height: 40,
             ),
             Icon(Icons.account_circle,size:100,color: const Color.fromARGB(255, 219, 171, 25),),
             SizedBox(
              height: 20,
             ),
             Column(
              children: <Widget>[
                
                 Padding(
                  padding: EdgeInsets.only(left: 30,right: 30),
                  child: TextFormField(
                    controller: user_name,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      prefixIconColor:Color.fromARGB(255, 187, 148, 48), 
                      labelText: "User Name",
                    ),
                  ),
                ),
            
                 Padding(
                  padding: EdgeInsets.only(left: 30,right: 30),
                  child: TextFormField(
                    controller: password,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      prefixIconColor:Color.fromARGB(255, 187, 148, 48), 
                      labelText: "Password",
                    ),
                  ),
                ),
                 
                SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(200, 20),
                    backgroundColor: Color.fromARGB(255, 187, 148, 48),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(0), // Adjust the value as needed
    ),
                  ),
                  onPressed: (){
                  BlocProvider.of<LogBloc>(context).add(
                     LogEvent(user_name.text,password.text)   
                      );
                }, child: state is Logingin? CircularProgressIndicator() : state is LoginSuccess?((){
                  Navigator.of(context).push(
  MaterialPageRoute<Profile>(
    builder: (context) {
   return  BlocProvider<ProfileBloc>(
            create: (context) => ProfileBloc(),
        child: Profile(),
      );}));
                })()
                 : state is LoginFailed? Text("Failed",style: TextStyle(color: Colors.red),):Text("Login")),
               
              ],
             )
          ],
        
        );
      }
    ),
   );
  }

}