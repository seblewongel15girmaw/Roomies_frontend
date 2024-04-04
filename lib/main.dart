import 'package:begara_mobile/config/routes.dart';
import 'package:begara_mobile/feauters/auth/data/repository/userRepository.dart';
import 'package:begara_mobile/feauters/auth/domain/repository/userRepository.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/gender_bloc.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/image_bloc.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/login_bloc.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/others_bloc.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/profile_bloc.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/register_bloc.dart';
import 'package:begara_mobile/feauters/auth/presentation/pages/login.dart';
import 'package:begara_mobile/feauters/auth/presentation/pages/profile.dart';
import 'package:begara_mobile/feauters/auth/presentation/pages/register.dart';
import 'package:begara_mobile/feauters/auth/presentation/widgets/registerform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Routes appRoutes=Routes();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: "/login",
      onGenerateRoute: appRoutes.generateRoute,
      
      
    );
  }
 }

