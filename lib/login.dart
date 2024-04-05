import 'package:begara_mobile/blocks/login/login_bloc.dart';
import 'package:begara_mobile/blocks/login/login_event.dart';
import 'package:begara_mobile/blocks/login/login_state.dart';
import 'package:begara_mobile/blocks/profile/profile_bloc.dart';
import 'package:begara_mobile/blocks/register/password_visiblity_event.dart';
import 'package:begara_mobile/blocks/register/register_bloc.dart';
import 'package:begara_mobile/blocks/register/register_event.dart';
import 'package:begara_mobile/blocks/register/register_state.dart';
import 'package:begara_mobile/profile.dart';
import 'package:begara_mobile/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocks/register/password_visiblity_bloc.dart';
import 'blocks/register/password_visiblity_state.dart';

class Login extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    bool _isObscure=true;
    final _formKey=GlobalKey<FormState>();
    TextEditingController user_name=TextEditingController();
    
    TextEditingController password=TextEditingController();
    


   return Scaffold(
    backgroundColor: Colors.black,
    body: BlocConsumer<LogBloc,LogState> (
      listener: (context,state){
                    Navigator.of(context).push(
                   MaterialPageRoute<Profile>(
                     builder: (context) {
                    return  BlocProvider<ProfileBloc>(
                             create: (context) => ProfileBloc(),
                         child: Profile(),
                       );}));
                   },
      builder: (context,state) {
        return SingleChildScrollView(
          child: Column(
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
               Form(
                key: _formKey,
                 child: Column(
                  children: <Widget>[
                    
                     Padding(
                      padding: EdgeInsets.only(left: 30,right: 30),
                      child: TextFormField(
                        validator: (value){
                            if (value==Null || value!.isEmpty){
                              return "this field can not be null";
                            }
                            else if (value.length>20){
                              return "too long";
                            }
                          },
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
                      child: BlocBuilder<PassBloc,PassState>(
                        builder: (context,state) {
                          return TextFormField(
                            validator: (value){
                          if (value==Null || value!.isEmpty){
                            return "this field can not be null";
                          }
                         else if (value.length<1){
                            return "password should be longer than 4 characters";
                          }
                        },
                            obscureText: _isObscure,
                            controller: password,
                            decoration: InputDecoration(
                              
                              prefixIcon: Icon(Icons.lock),
                              prefixIconColor:Color.fromARGB(255, 187, 148, 48), 
                              labelText: "Password",
                              suffixIconColor: Color.fromARGB(255, 187, 148, 48), 
                              suffixIcon: 
                                IconButton(onPressed: (){
                                _isObscure=!_isObscure;
                                  BlocProvider.of<PassBloc>(context).add(PassEvent());
                          
                                }, icon: _isObscure?Icon(Icons.visibility):
                                Icon(Icons.visibility_off) )
                              
                            ),
                          );
                        }
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
                      if(_formKey.currentState!.validate()){BlocProvider.of<LogBloc>(context).add(
                         LogEvent(user_name.text,password.text)   
                          );}
                    }, child: state is Logingin? CircularProgressIndicator() : state is LoginSuccess?Text(
                      "Success",style: TextStyle(color: Colors.green)
                    )
                     : state is LoginFailed? Text("Failed",style: TextStyle(color: Colors.red),):Text("Login")),
                   
                  ],
                 ),
               )
            ],
          
          ),
        );
      }
    ),
   );
  }

}