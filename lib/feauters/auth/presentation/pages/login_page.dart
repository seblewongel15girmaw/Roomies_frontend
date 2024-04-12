import 'package:begara_mobile/core/util/validators.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/login/login.dart';
import 'package:begara_mobile/feauters/auth/presentation/widgets/text_fields.dart';
import 'package:begara_mobile/feauters/auth/presentation/widgets/submit_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController userName = TextEditingController();
    TextEditingController password = TextEditingController();
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
          height: 20,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "/register");
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25),
                      bottomRight: Radius.circular(25)),
                  color: Colors.amber),
              height: 50,
              width: 120,
              child: Center(
                  child: Text(
                "Register",
                style: TextStyle(fontSize: 20, color: Colors.white),
              )),
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Icon(
          Icons.account_circle,
          size: 100,
          color: Colors.amber,
        ),
        Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: <Widget>[
                CustomTextField(
                  controller: userName,
                  labelText: "User Name",
                  prefixIcon: Icons.person,
                  validator: nameValidator,
                ),
                PasswordFormField(controller: password, labelText: "Password"),
                SizedBox(height: 50),
                SubmitButton(
                    bloc: BlocProvider.of<LogBloc>(context),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        BlocProvider.of<LogBloc>(context)
                            .add(LogEvent(userName.text, password.text));
                      }
                    },
                    buttonText: "Login",
                    listener: (context, state) {
                      if (state is LogSuccess) {
                        Navigator.pushNamed(context, '/profile');
                      }
                    },
                    success: LogSuccess,
                    fail: LogFailure,
                    progress: Logining)
              ],
            ),
          ),
        )
      ]),
    );
  }
}
