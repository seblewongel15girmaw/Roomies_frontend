import 'package:begara_mobile/config/routes.dart';
import 'package:begara_mobile/core/util/sharedPreference.dart';
import 'package:begara_mobile/injectionContainer.dart';
import 'package:flutter/material.dart';

void main() async{
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Routes appRoutes=Routes();
    return FutureBuilder<bool>(
      future:_getInitialRoute(),
      builder: (context,snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting){
          return CircularProgressIndicator();
        }
        else if(snapshot.hasError){
          return Text("${snapshot.error}");
        }
        else {
          return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute:snapshot.data==true?"/login":"/login" ,
        onGenerateRoute: appRoutes.generateRoute,      
      );
        }
      },
       
    );
  }
 }
Future<bool> _getInitialRoute() async {
  final stored= await SharedPreferencesService.getString("token");
        if(stored==null){
          return false;
        }
        else{
          return true;
        }
  }

