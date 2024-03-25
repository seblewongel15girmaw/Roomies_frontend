import 'package:begara_mobile/blocks/login/login_bloc.dart';
import 'package:begara_mobile/blocks/register/password_visiblity_bloc.dart';
import 'package:begara_mobile/blocks/register/password_visiblity_event.dart';
import 'package:begara_mobile/blocks/register/password_visiblity_state.dart';
import 'package:begara_mobile/blocks/register/register_bloc.dart';
import 'package:begara_mobile/blocks/register/register_event.dart';
import 'package:begara_mobile/blocks/register/register_state.dart';
import 'package:begara_mobile/login.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class Register extends StatelessWidget{
  

  @override
  Widget build(BuildContext context) {
    bool _isObscure= true;
    bool _isObscure2= true;
    final _formKey = GlobalKey<FormState>();
    TextEditingController full_name=TextEditingController();
    TextEditingController user_name=TextEditingController();
    TextEditingController email=TextEditingController();
    TextEditingController password=TextEditingController();
    TextEditingController repassword=TextEditingController();

   return Scaffold(
    backgroundColor: Colors.black,
    body: BlocBuilder<RegBloc,RegState> (
      builder: (context,state) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 80,
               ),
               Align(
                alignment: Alignment.topRight,
                 child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
            MaterialPageRoute<Login>(
              builder: (context) {
             return  BlocProvider<LogBloc>(
              create: (context) => LogBloc(),
          child: Login(),
                );}));
                  },
                   child: Container(
                    height: 40,
                    width: 140,
                    decoration: BoxDecoration(color: Color.fromARGB(255, 187, 148, 48),borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20)
                    )),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Log In",
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
               Text("Register",
               style: TextStyle(
                fontSize: 35,
                
                color: Colors.white
                
               ),),
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
                        controller: full_name,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          prefixIconColor:Color.fromARGB(255, 187, 148, 48), 
                          hoverColor:  Color.fromARGB(255, 187, 148, 48),
                          labelText: "Full Name",
                          focusColor:  Color.fromARGB(240, 224, 176, 53)
                        ),
                      ),
                    ),
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
                      child: TextFormField(
                        validator: (value){
                          if (value==Null || value!.isEmpty){
                            return "this field can not be null";
                          }
                         else if (!EmailValidator.validate(value)){
                            return "Invalid Email";
                          }
                        },
                        controller: email,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          prefixIconColor:Color.fromARGB(255, 187, 148, 48), 
                          labelText: "Email",
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
                         else if (value.length<5){
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
                     Padding(
                      padding: EdgeInsets.only(left: 30,right: 30),
                      child:BlocBuilder<PassBloc,PassState>(
                        builder: (context,state) {
                          return TextFormField(
                            validator: (value){
                          if (value==Null || value!.isEmpty){
                            return "this field can not be null";
                          }
                         else if (value.length<5){
                            return "password should be longer than 4 characters";
                          }
                        else if(value!=password.text){
                          return "the two password mismatch";
                        }
                        },
                            obscureText: _isObscure2,
                            controller: repassword,
                            decoration: InputDecoration(
                              
                              prefixIcon: Icon(Icons.lock),
                              prefixIconColor:Color.fromARGB(255, 187, 148, 48), 
                              labelText: "Re-Password",
                              suffixIconColor: Color.fromARGB(255, 187, 148, 48), 
                              suffixIcon: 
                                IconButton(onPressed: (){
                                _isObscure2=!_isObscure2;
                                  BlocProvider.of<PassBloc>(context).add(PassEvent());
                          
                                }, icon: _isObscure2?Icon(Icons.visibility):
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
                        if(_formKey.currentState!.validate()){
                          BlocProvider.of<RegBloc>(context).add(
                         RegEvent(full_name.text, user_name.text,email.text, password.text)   
                          );
                        }
                        
                      
                    }, child: state is Registration? CircularProgressIndicator() : state is Registerd? Text("Registered",style: TextStyle(color: Colors.green),): state is NotRegisterd? Text("Failed",style: TextStyle(color: Colors.red),):Text("register")),
                   
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