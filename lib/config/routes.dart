import 'package:begara_mobile/feauters/auth/presentation/bloc/login/login_bloc.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/others/censor/censor_bloc.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/others/dropDown/dropdown.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/others/image/image_bloc.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/others/radioOptions/radio_bloc.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/profile/profile_bloc.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/register/register_bloc.dart';
import 'package:begara_mobile/feauters/auth/presentation/pages/login_page.dart';
import 'package:begara_mobile/feauters/auth/presentation/pages/create_profile_page.dart';
import 'package:begara_mobile/feauters/auth/presentation/pages/registeration_page.dart';
import 'package:begara_mobile/feauters/recommendation/presentation/bloc/roommate/roommate_bloc.dart';
import 'package:begara_mobile/feauters/recommendation/presentation/bloc/users_profile/users_profile_bloc.dart';
import 'package:begara_mobile/feauters/recommendation/presentation/pages/display_matches_page.dart';
import 'package:begara_mobile/feauters/recommendation/presentation/pages/user_profile_page.dart';
import 'package:begara_mobile/injectionContainer.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Routes{
  
  
  Route<dynamic> generateRoute(RouteSettings settings){
    
    switch(settings.name){
      case '/login':
      return MaterialPageRoute(
        builder: (_)=>MultiBlocProvider(providers: [
        BlocProvider<PassBloc>(create: (context)=>PassBloc()),
        BlocProvider<LogBloc>(create: (context)=>sl<LogBloc>()),
       ],
        child: LoginPage(),
        ),
      );

      case '/register':
      return MaterialPageRoute(builder: (_)=>MultiBlocProvider(providers: [
        BlocProvider<PassBloc>(create: (context)=>PassBloc()),
        BlocProvider<RegBloc>(create: (context) =>sl<RegBloc>() ),
        ],
        child: RegisterPage(),
        ),);
      case '/profile':
      return MaterialPageRoute(builder: (_)=>MultiBlocProvider(providers: [
        BlocProvider<DropDownBloc>(create: (context) => DropDownBloc()) ,
        BlocProvider<ImageBloc>(create: (context) => ImageBloc()) ,
        BlocProvider<RadioBloc>(create: (context) => RadioBloc()) ,
        BlocProvider<ProfileBloc>(create: (context) =>sl<ProfileBloc>())],
        child: ProfilePage(),
        ),);
      case '/roommate':
      return MaterialPageRoute(builder: (_)=>MultiBlocProvider(providers: [
        BlocProvider<RoommateBloc>(create: (context) => sl<RoommateBloc>()) ,],
        child: DisplayMatchesPage() ,
        ),);
       case '/matchprofile':
      return MaterialPageRoute(builder: (_)=>MultiBlocProvider(providers: [
        BlocProvider<UserProfileBloc>(create: (context) => sl<UserProfileBloc>()) ,],
        child: UserProfilePage(user: settings.arguments,) ,
        ),);
      default:
      return MaterialPageRoute(
        builder: (_)=>MultiBlocProvider(providers: [
        BlocProvider<PassBloc>(create: (context)=>PassBloc()),
        BlocProvider<LogBloc>(create: (context)=>sl<LogBloc>()),
       ],
        child: LoginPage(),
        ),
      );
    }

  }
}