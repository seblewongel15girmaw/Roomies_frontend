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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Routes{
  UserRepo userRepo=UserRepoImpl();
  Route<dynamic> generateRoute(RouteSettings settings){
    final args= settings.arguments;
    switch(settings.name){
      case '/login':
      return MaterialPageRoute(
        builder: (_)=>MultiBlocProvider(providers: [
        BlocProvider<PassBloc>(create: (context)=>PassBloc()),
        BlocProvider<LogBloc>(create: (context)=>LogBloc(userRepo)),
       ],
        child: LoginPage(),
        ),
      );

      case '/register':
      return MaterialPageRoute(builder: (_)=>MultiBlocProvider(providers: [
        BlocProvider<PassBloc>(create: (context)=>PassBloc()),
        BlocProvider<RegBloc>(create: (context) =>RegBloc(userRepo) ),
        ],
        child: RegisterPage(),
        ),);
      case '/profile':
      return MaterialPageRoute(builder: (_)=>MultiBlocProvider(providers: [
        BlocProvider<ImageBloc>(create: (context) => ImageBloc()) ,
        BlocProvider<RadioBloc>(create: (context) => RadioBloc()) ,
        BlocProvider<ProfileBloc>(create: (context) =>ProfileBloc(userRepo))],
        child: ProfilePage(),
        ),);
      default:
      return MaterialPageRoute(
        builder: (_)=>MultiBlocProvider(providers: [
        BlocProvider<PassBloc>(create: (context)=>PassBloc()),
        BlocProvider<LogBloc>(create: (context)=>LogBloc(userRepo)),
       ],
        child: LoginPage(),
        ),
      );
    }

  }
}