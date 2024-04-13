import 'package:begara_mobile/core/util/validators.dart';
import 'package:begara_mobile/feauters/auth/presentation/widgets/switch_screen_button.dart';
import 'package:flutter/material.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/register/register.dart';
import 'package:begara_mobile/feauters/auth/presentation/widgets/text_fields.dart';
import 'package:begara_mobile/feauters/auth/presentation/widgets/submit_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatelessWidget {
  bool _isObscure = true;
  bool _isObscure2 = true;
  final _formKey = GlobalKey<FormState>();
  TextEditingController full_name = TextEditingController();
  TextEditingController user_name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController repassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
            height: 35,
          ),
          Align(
              alignment: Alignment.topRight,
              child: SwitchScreen(
                pageRoute: "/login",
                buttonName: "Log IN",
                direction: "left",
              )),
          SizedBox(
            height: 15,
          ),
          Icon(
            Icons.account_circle,
            size: 100,
            color:  Color.fromARGB(255, 187, 148, 48)
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: Column(
                    children: <Widget>[
                      CustomTextField(
                          controller: full_name,
                          labelText: "Full Name",
                          prefixIcon: Icons.person,
                          validator: nameValidator,),
                      CustomTextField(
                          controller: user_name,
                          labelText: "User Name",
                          prefixIcon: Icons.person,
                          validator: nameValidator,),
                      CustomTextField(
                          controller: email,
                          labelText: "Email",
                          prefixIcon: Icons.email,
                          validator: emailValidator,),
                      PasswordFormField(
                        controller: password,
                        labelText: "Password",
                        validator: passwordValidator,
                      ),
                      PasswordFormField(
                        controller: repassword,
                        labelText: "RE-enter Password",
                        validator: (value){
                          dynamic result =repasswordValidator(value, password.text);
                          return result;
                        },
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      SubmitButton(
                          bloc: BlocProvider.of<RegBloc>(context),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              BlocProvider.of<RegBloc>(context).add(RegEvent(
                                  full_name.text,
                                  user_name.text,
                                  email.text,
                                  password.text));
                            }
                          },
                          buttonText: "Register",
                          listener: (context, state) {
                            Navigator.pushNamed(context, "/profile");
                          },
                          success: RegisterSuccess,
                          fail: RegisterFailed,
                          progress: RegisterFailed)
                    ],
                  ),
                ),
              )
            ],
          )
        ]),
      ),
    );
  }
}
