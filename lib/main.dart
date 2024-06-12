import 'package:begara_mobile/config/routes.dart';
import 'package:begara_mobile/core/theme/theme.dart';
import 'package:begara_mobile/core/util/sharedPreference.dart';
import 'package:begara_mobile/feauters/auth/data/data_source/firebase_api.dart';
import 'package:begara_mobile/firebase_options.dart';
import 'package:begara_mobile/injectionContainer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'feauters/house/presentation/bloc/user/theme/theme_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FireBaseApi().initNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Routes appRoutes = Routes();
    return FutureBuilder<bool>(
      future: _getInitialRoute(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        else {

          return BlocProvider<ThemeBloc>(
            create: (BuildContext context) =>ThemeBloc(),
              child: BlocBuilder<ThemeBloc, ThemeMode>(
              builder: (context, state) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Flutter Demo',
                  theme: lightMode,
                  darkTheme: darkMode,
                  initialRoute: snapshot.data == true ? "/homePage" : "/login",
                  onGenerateRoute: appRoutes.generateRoute,
                );
              },));
        }
      },

    );
  }
}

Future<bool> _getInitialRoute() async {
  final stored = await SharedPreferencesService.getString("token");
  if (stored == null) {
    return false;
  }
  if (Jwt.isExpired(stored)) {
    return false;
  } else {
    return true;
  }
}

