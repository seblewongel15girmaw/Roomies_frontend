import 'package:flutter/material.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/register/register.dart';
import 'package:begara_mobile/feauters/auth/presentation/widgets/text_fields.dart';
import 'package:begara_mobile/feauters/auth/presentation/widgets/submit_buttons.dart';
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
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/login");
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        bottomLeft: Radius.circular(25)),
                    color: Colors.amber),
                height: 50,
                width: 120,
                child: Center(
                    child: Text(
                  "Log in",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Icon(
            Icons.account_circle,
            size: 100,
            color: Colors.amber,
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
                          prefixIcon: Icons.person),
                      CustomTextField(
                          controller: user_name,
                          labelText: "User Name",
                          prefixIcon: Icons.person),
                      CustomTextField(
                          controller: email,
                          labelText: "Email",
                          prefixIcon: Icons.email),
                      PasswordFormField(
                        controller: password,
                        labelText: "Password",
                      ),
                      PasswordFormField(
                        controller: repassword,
                        labelText: "RE-enter Password",
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
