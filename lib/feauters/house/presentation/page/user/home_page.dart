import 'dart:developer';
import 'package:begara_mobile/feauters/auth/presentation/bloc/location/locations.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/logout/logout.dart';
import 'package:begara_mobile/feauters/auth/presentation/pages/create_profile_page.dart';
import 'package:begara_mobile/feauters/chat/domain/entity/contacts.dart';
import 'package:begara_mobile/feauters/chat/presentation/pages/contacts_page.dart';
import 'package:begara_mobile/feauters/recommendation/presentation/pages/display_matches_page.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:begara_mobile/feauters/house/presentation/bloc/user/house/house_bloc.dart';
import 'package:begara_mobile/feauters/house/presentation/bloc/user/house/house_event.dart';
import 'package:begara_mobile/feauters/house/presentation/bloc/user/house/house_state.dart';
import 'package:begara_mobile/feauters/house/presentation/widget/user/house_card.dart';

import 'package:begara_mobile/injectionContainer.dart';

import '../../../../../config/routes.dart';
import '../../../../auth/presentation/bloc/others/dropDown/dropdown_bloc.dart';
import '../../../../auth/presentation/bloc/others/image/image_bloc.dart';
import '../../../../auth/presentation/bloc/others/radioOptions/radio_bloc.dart';
import '../../../../auth/presentation/bloc/profile/profile_bloc.dart';
import '../../../../chat/presentation/blocs/contacts/contacts_bloc.dart';
import '../../../../recommendation/presentation/bloc/roommate/roommate_bloc.dart';



class HomeScreen extends StatefulWidget{

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    @override
    void initState(){
      super.initState();
      houseBloc.add(InitialEvent());
    }

    HouseBloc houseBloc= sl<HouseBloc>();

    @override
    Widget build(BuildContext context){

      double width=MediaQuery.of(context).size.width;
      var index;

      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
          body: BlocConsumer<HouseBloc, HouseState>(
            bloc: houseBloc,
            buildWhen: (previous, current)=> current is !HouseActionState ,
            listenWhen:(previous, current)=> current is HouseActionState ,
            listener: (BuildContext context, Object? state) { },
            builder: (context, state) {
              switch(state.runtimeType){
              // case InitialState:
                case LoadingState:
                  return Center(
                    child: CircularProgressIndicator(color: Colors.white,),
                  );

                case HouseSuccessState:
                  final successState =state as HouseSuccessState;
                  return SafeArea(
                    child:Center(
                      child: Container(
                        width: width*0.9,
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(255, 253,208,1),
                                borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomLeft: Radius.circular(20))
                              ),
                              margin: EdgeInsets.symmetric(vertical: 4),
                              child: Column(
                                // alignment: Alignment.center,
                                children: [
                                  Container(
                                    child: Image(image: AssetImage("asset/reminder.webp"),
                                      fit: BoxFit.contain,
                                      height: 60,
                                      width: 60,),
                                  ),

                                  Container(
                                    width: width*0.9,
                                    child: TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pushNamed("/profile");
                                        },
                                        child: Text("Please Fill In Your Profile Information",
                                            style:GoogleFonts.pressStart2p(
                                              fontSize: 10,
                                            ))),
                                    // top:114,
                                    //     left:width*0.22
                                  )
                                ],
                              ),
                            ),

                            SizedBox(height: 8,),

                            Expanded(
                              child: ListView.builder(
                                  itemCount: successState.houseList.length,
                                  itemBuilder: (context, index){
                                    return GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pushNamed("/houseDetail",arguments: successState.houseList[index]);
                                        },
                                        child:HouseCard(housemodel: successState.houseList[index])

                                    );
                                  }
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );

                case HouseErrorState:
                  return Center(
                    child: Text("Error has occured"),
                  );
                default:
                  return Container();
              }

            },
          ));
    }
}


class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState()=> _HomePageState();
}

class _HomePageState extends State<HomePage>{
  //
  List<Widget> pagesList=[
    MultiBlocProvider(providers: [
      BlocProvider<HouseBloc>(create: (context)=>sl<HouseBloc>()),
    ],
      child: HomeScreen(),
    ),
    MultiBlocProvider(providers: [
      BlocProvider<ContactsBloc>(create: (context)=>sl<ContactsBloc>()),
    ],
      child: ContactsPage(),
    ),
    MultiBlocProvider(providers: [
      BlocProvider<RoommateBloc>(create: (context) => sl<RoommateBloc>()) ,],
      child: DisplayMatchesPage() ,
    ),
    MultiBlocProvider(providers: [
      BlocProvider<DropDownBloc>(create: (context) => DropDownBloc()) ,
      BlocProvider<ImageBloc>(create: (context) => ImageBloc()) ,
      BlocProvider<RadioBloc>(create: (context) => RadioBloc()) ,
      BlocProvider<ProfileBloc>(create: (context) =>sl<ProfileBloc>()),
      BlocProvider<LocationBloc>(create: (context)=>sl<LocationBloc>(),)],
      child: ProfilePage(),
    )
  ];

  int index = 0;

  List pageTitles=[
    "",
    "All Chats",
    "Compatible Roommates",
    "Profile"
  ];

  @override
  Widget build(BuildContext context){
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.white,
          bottomNavigationBar: CurvedNavigationBar(
            backgroundColor: Colors.white,
            color: Colors.black87,
            animationDuration: Duration(milliseconds: 500),
            buttonBackgroundColor: Color.fromRGBO(244, 196, 48,0.9),
            onTap: (idx){
              setState(() {
                index=idx;
              });
            },
            items: const [
              CurvedNavigationBarItem(child:  Icon(Icons.home, color: Colors.white,)),
              CurvedNavigationBarItem(child:  Icon(Icons.comment, color: Colors.white)),
              CurvedNavigationBarItem(child:  Icon(Icons.link_rounded, color: Colors.white)),
              CurvedNavigationBarItem(child:  Icon(Icons.person, color: Colors.white))
            ],
          ),
          appBar: AppBar(
            title: Text(pageTitles[index], style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),),
            elevation: 0,
            backgroundColor: Color.fromRGBO(244, 196, 48,0.9),
            actions: [Icon(Icons.star_border_outlined)],
          ),
          drawer: Drawer(
            backgroundColor: Colors.black,
            child: ListView(
              children:  [
                SizedBox(height: 35),
                CircleAvatar(radius: 35,),
                SizedBox(height: 13,),
                Divider(),
                SizedBox(height: 25,),
                ListTile(
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  leading: Icon(Icons.settings),
                  title: Text("Setting", style: TextStyle(fontSize: 13),),
                ),
                ListTile(
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  leading: Icon(Icons.notifications),
                  title: Text("Notification", style: TextStyle(fontSize: 13)),
                ),
                ListTile(
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  leading: Icon(Icons.color_lens),
                  trailing: Icon(Icons.toggle_off_outlined),
                  title: Text("Theme", style: TextStyle(fontSize: 13)),
                ),
                ListTile(
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  leading: Icon(Icons.help),
                  title: Text("Help", style: TextStyle(fontSize: 13)),
                ),
                ListTile(
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.pushNamed(context, "/change-password");
                    // scaffoldKey.currentState!.openEndDrawer();
                  },
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  leading: Icon(Icons.key),
                  title: Text("Change Credentials", style: TextStyle(fontSize: 13)),
                ),
                ListTile(
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  leading: Icon(Icons.info),
                  title: Text("About Us", style: TextStyle(fontSize: 13)),
                ),
                ListTile(
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.pushNamed(context, "/give-feedback");
                    // scaffoldKey.currentState!.openEndDrawer();
                  },
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  leading: Icon(Icons.feedback_sharp),
                  title: Text("Feedback and rate", style: TextStyle(fontSize: 13)),
                ),
                ListTile(
                  onTap: (){
                    BlocProvider.of<LogoutBloc>(context).add(LogoutEvent());
                  },
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  leading: Icon(Icons.logout),
                  title: Text("Sign Out", style: TextStyle(fontSize: 13)),
                ),
                ListTile(
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.pushNamed(context, "/deactivate");
                  },
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  leading: Icon(Icons.remove_circle),
                  title: Text("Deactivate Account", style: TextStyle(fontSize: 13)),
                ),
              ],
            ),
          ),
          body: BlocListener<LogoutBloc,LogOutState>(

            listener: (context,state) {
              if(state is LoggedOut){
                Navigator.pushNamed(context, "/login");
              }
            },
            child:  IndexedStack(
                index: index,
                children: pagesList,)
          )
    );       
            }
         
  }
