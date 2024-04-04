import 'package:begara_mobile/feauters/auth/presentation/bloc/login_bloc.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/login_event.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/login_state.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/others_bloc.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/others_event.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/others_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

InputDecoration buildInputDecoration(String labelText, IconData prefixIcon, Color prefixIconColor,Function? function, {IconData? suffixIcon, Color? suffixIconColor}) {
  return InputDecoration(
    suffix: GestureDetector(
      onTap: (){
        function;
      },
      child: Icon(suffixIcon, color: suffixIconColor),
    ),
    prefixIcon: Icon(prefixIcon),
    prefixIconColor: prefixIconColor,
    labelText: labelText,
    
  );
}

class LoginForm extends StatelessWidget{
  final _formKey=GlobalKey<FormState>();
  TextEditingController userName=TextEditingController();
  TextEditingController password=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: <Widget>[
            TextFormField(
              validator: (value){
                if (value == null || value.isEmpty){
                  return "This field can not be null";
                } else if (value.length > 20) {
                  return "Too long";
                }
              },
              controller: userName,
              decoration: buildInputDecoration("User Name", Icons.person, Color.fromARGB(255, 187, 148, 48),null),
            ),
            BlocBuilder<PassBloc,PassState>(
              builder: (context,state) {
                return TextFormField(
                  validator: (value){
                    if (value == null || value.isEmpty){
                      return "This field can not be null";
                    } else if (value.length < 1) {
                      return "Password should be longer than 4 characters";
                    }
                  },
                  obscureText: state is Hidden,
                  controller: password,
                  decoration:InputDecoration(
                    label: Text("Password"),
                    prefixIcon: Icon(Icons.lock),
                    prefixIconColor:Color.fromARGB(255, 187, 148, 48) ,
                    suffix: GestureDetector(
                      onTap: (){
                        BlocProvider.of<PassBloc>(context).add(PassEvent());
                      },
                      child: state is Hidden?
                      Icon(Icons.visibility) :Icon(Icons.visibility_off) ,
                    )
                  ),
                  
                );
              }
            ),
            SizedBox(height: 50),
            BlocConsumer<LogBloc,LogState>(
              listener: (context, state) {
                if(state is LogSuccess){
                  Navigator.pushNamed(context, '/profile');
                }
              },
              builder: (context,state) {
                return ElevatedButton(
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
                      BlocProvider.of<LogBloc>(context).add(LogEvent(userName.text, password.text));
                    }
                  },
                  child:state is Logining?CircularProgressIndicator() :state is LogSuccess?Text("Success"): 
                  state is LogFailure?Text("LOGIN FAILED"):Text("login"),
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}