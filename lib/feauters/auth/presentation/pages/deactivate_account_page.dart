import 'package:begara_mobile/core/util/validators.dart';
import 'package:begara_mobile/feauters/auth/domain/Entities/user.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/deactivate/deactivate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeactivateAccountPage extends StatelessWidget {
  UserEntity user;
  DeactivateAccountPage({required this.user});
  final formkey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeactivateBloc, DeactivateState>(
        listener: (context, state) {
      if (state is DeactivateSuccess) {
        Navigator.pushNamed(context, "/homePage");
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: user.activateStatus == 1
              ? Text("Deactivate Account")
              : Text("Activate Account"),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor:
              Color.fromRGBO(244, 196, 48, 0.9), // Make the app bar transparent
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.activateStatus == 1
                      ? 'Why Deactivate Your Account?'
                      : 'Why Reactivate Your Account?',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber[700],
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  user.activateStatus == 1
                      ? 'If you successfully found a roommate, to stop receiving further recommendations and notifications, you can deactivate your account. You can reactivate your account within 12 months.'
                      : "Found a roommate and deactivated your account? Reactivate within 12 months to get new recommendations and notifications. Don't miss out – reactivate today!",
                  style: TextStyle(color: Colors.amber[800]),
                ),
                SizedBox(height: 16),
                TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: 'Enter your password',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                    validator: passwordValidator),
                SizedBox(height: 16),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<DeactivateBloc>(context).add(
                        DeactivateEvent(password: passwordController.text));
                  },
                  child: user.activateStatus==1?Text('Deactivate Account'):Text('Reactivate Account'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber, // Set button color to amber
                    minimumSize:
                        Size(double.infinity, 48), // Make the button full-width
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
