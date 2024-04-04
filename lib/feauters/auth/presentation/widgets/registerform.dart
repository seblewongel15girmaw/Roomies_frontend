
import 'package:begara_mobile/core/util/validators.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/others_bloc.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/others_event.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/others_state.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/register_bloc.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/register_event.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterForm extends StatelessWidget{
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

   return 
        Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

               SizedBox(
                height: 20,
               ),
               Form(
                key: _formKey,
                 child: Padding(
                  padding: EdgeInsets.only(left:30,right:30),
                   child: Column(
                    children: <Widget>[
                      TextFormField(
                        validator: nameValidator,
                        controller: full_name,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          prefixIconColor:Color.fromARGB(255, 187, 148, 48), 
                          hoverColor:  Color.fromARGB(255, 187, 148, 48),
                          labelText: "Full Name",
                          focusColor:  Color.fromARGB(240, 224, 176, 53)
                        ),
                      ),
                       TextFormField(
                        validator: nameValidator,
                         controller: user_name,
                         decoration: InputDecoration(
                           prefixIcon: Icon(Icons.person),
                           prefixIconColor:Color.fromARGB(255, 187, 148, 48), 
                           labelText: "User Name",
                         ),
                       ),
                      TextFormField(  
                        validator: emailValidator,                      
                        controller: email,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          prefixIconColor:Color.fromARGB(255, 187, 148, 48), 
                          labelText: "Email",
                        ),
                      ),
                      BlocBuilder<PassBloc,PassState>(
                        builder: (context,state) {
                          return TextFormField(
                                 validator: passwordValidator,
                                 obscureText: _isObscure,
                                 controller: password,
                                 decoration: InputDecoration(
                                   
                                   prefixIcon: Icon(Icons.lock),
                                   prefixIconColor:Color.fromARGB(255, 187, 148, 48), 
                                   labelText: "Password",
                                   suffixIconColor: Color.fromARGB(255, 187, 148, 48), 
                                   suffixIcon: 
                                     IconButton(onPressed: (){
                                    BlocProvider.of<PassBloc>(context).add(PassEvent());
                                    _isObscure=!_isObscure;
                                     }, icon: _isObscure? Icon(Icons.visibility):Icon(Icons.visibility_off)
                                   )
                                   
                                 ));
                        }
                      ),
                           
                       BlocBuilder<PassBloc,PassState>(
                         builder: (context,state) {
                           return TextFormField(
                                 validator: (value){
                                  passwordValidator(value);
                                  if (value != password.text) {
                                    return "The two passwords mismatch";
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
                                    BlocProvider.of<PassBloc>(context).add(PassEvent());
                                    _isObscure2=!_isObscure2;
                               
                                     }, icon: _isObscure2? Icon(Icons.visibility):Icon(Icons.visibility_off)
                                     
                                 ),
                               ));
                         }
                       ),
                         
                      SizedBox(
                        height: 50,
                      ),
                      BlocBuilder<RegBloc,RegisterState>(
                        builder: (context,state) {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(200, 20),
                              backgroundColor: state is Registering? Colors.grey:
                              state is RegisterFailed? Colors.red: 
                              state is RegisterSuccess? Colors.green:Color.fromARGB(255, 187, 148, 48),
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(0), // Adjust the value as needed
                           ),
                            ),
                            onPressed: (){
                            if(_formKey.currentState!.validate()){
                              BlocProvider.of<RegBloc>(context).add(
                              RegEvent(full_name.text, user_name.text, email.text, password.text));
                            }
                          }, child:
                          state is Registering?CircularProgressIndicator():
                          state is RegisterSuccess? Text("registered"):
                          state is RegisterFailed? Text("Failed"):Text("Register"));
                        }
                      ),
                     
                    ],
                   ),
                 ),
               )
            ],
          
          );
        
      }
}