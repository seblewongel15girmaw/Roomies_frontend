import 'dart:io';

import 'package:begara_mobile/feauters/auth/presentation/bloc/user_status/user_status_bloc.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/user_status/user_status_event.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/user_status/user_status_state.dart';
import 'package:begara_mobile/feauters/auth/presentation/pages/myprofile_page.dart';
import 'package:begara_mobile/feauters/chat/presentation/pages/contacts_page.dart';
import 'package:begara_mobile/feauters/house/presentation/widget/user/drawer.dart';
import 'package:begara_mobile/feauters/recommendation/presentation/pages/display_matches_page.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/users_profile/user_profile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:begara_mobile/feauters/house/presentation/bloc/user/house/house_bloc.dart';
import 'package:begara_mobile/feauters/house/presentation/bloc/user/house/house_event.dart';
import 'package:begara_mobile/feauters/house/presentation/bloc/user/house/house_state.dart';
import 'package:begara_mobile/feauters/house/presentation/widget/user/house_card.dart';
import 'package:begara_mobile/injectionContainer.dart';

import '../../../../auth/presentation/bloc/logout/logout.dart';
import '../../../../auth/presentation/bloc/others/censor/censor_bloc.dart';
import '../../../../auth/presentation/bloc/users_profile/users_profile_bloc.dart';
import '../../../../chat/presentation/blocs/contacts/contacts_bloc.dart';
import '../../../../recommendation/presentation/bloc/roommate/roommate_bloc.dart';
import '../../widget/user/no_of_room_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    houseBloc.add(InitialEvent());
  }

  HouseBloc houseBloc = sl<HouseBloc>();

    @override
    Widget build(BuildContext context){
      BlocProvider.of<UserStatusBloc>(context).add(ClickEvent());
      BlocProvider.of<UserProfileBloc>(context).add(UserProfileEvent(0));
      double width=MediaQuery.of(context).size.width;
      var index;

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          child: BlocConsumer<HouseBloc, HouseState>(
            bloc: houseBloc,
            buildWhen: (previous, current) => current is! HouseActionState,
            listenWhen: (previous, current) => current is HouseActionState,
            listener: (BuildContext context, Object? state) {},
            builder: (context, state) {
              switch (state.runtimeType) {

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
                              BlocBuilder<UserStatusBloc, UserStatusState>(
                                  builder: (context, state){
                            if(state is StatusSuccess){
                              final user=state.user;
                              if(user.profile_status == 0){
                                return Container(
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
                              );
                        }
                              else{
                                return SizedBox(height: 10);
                              }
                          }
                            else{
                              return Text("");
                            }

                        }),

                              SizedBox(height: 4,),
                              Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RoomNumberWidget(noOfRoom: 1,onTap: (){
                                    BlocProvider.of<HouseBloc>(context).add(FilterClickedEvent(1));
                                  },),
                                  SizedBox(width: 7,),
                                  RoomNumberWidget(noOfRoom: 2,onTap: (){
                                    BlocProvider.of<HouseBloc>(context).add(FilterClickedEvent(2));
                                  },),
                                  SizedBox(width: 7,),
                                  RoomNumberWidget(noOfRoom: 3,onTap: (){
                                    BlocProvider.of<HouseBloc>(context).add(FilterClickedEvent(3));
                                  },),
                                  SizedBox(width: 7,),
                                  RoomNumberWidget(noOfRoom: 4,onTap: (){
                                    BlocProvider.of<HouseBloc>(context).add(FilterClickedEvent(4));

                                  },),
                                ],
                              ),
          SizedBox(height: 17,),
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
                      ),);
                case HouseErrorState:
                  return Center(
                    child: Text("Error has occured"),
                  );
                default:
                  return Container();
              }
            },
          ),
        ));
  }}


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //
// <<<<<<< Updated upstream
//   List<Widget> pagesList = [
//     MultiBlocProvider(
//       providers: [
//         BlocProvider<HouseBloc>(create: (context) => sl<HouseBloc>()),
//       ],
// =======
  List<Widget> pagesList=[
    MultiBlocProvider(providers: [
      BlocProvider<HouseBloc>(create: (context)=>sl<HouseBloc>()),
      BlocProvider<UserStatusBloc>(create: (context)=>sl<UserStatusBloc>())
    ],
// >>>>>>> Stashed changes
      child: HomeScreen(),
    ),
    MultiBlocProvider(
      providers: [
        BlocProvider<ContactsBloc>(create: (context) => sl<ContactsBloc>()),
      ],
      child: ContactsPage(),
    ),
    MultiBlocProvider(
      providers: [
        BlocProvider<RoommateBloc>(create: (context) => sl<RoommateBloc>()),
      ],
      child: DisplayMatchesPage(),
    ),
    MultiBlocProvider(
      providers: [
        BlocProvider<UserProfileBloc>(
            create: (context) => sl<UserProfileBloc>()),
      ],
      child: MyProfile(),
    )
  ];

  int index = 0;

  List pageTitles = ["", "All Chats", "Compatible Roommates", "My Profile"];

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserProfileBloc>(context).add(UserProfileEvent(0));

    return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: CurvedNavigationBar(
          height: 64,
          backgroundColor: Color.fromRGBO(255, 255, 255, 0.3),
          color: Color.fromRGBO(0, 0, 0, 0.4),
          animationDuration: Duration(milliseconds: 500),
          buttonBackgroundColor: Color.fromRGBO(244, 196, 48, 0.9),
          onTap: (idx) {
            setState(() {
              index = idx;
            });
          },
          items: const [
            CurvedNavigationBarItem(
                child: Icon(
              Icons.home,
              color: Colors.white,
            )),
            CurvedNavigationBarItem(
                child: Icon(Icons.comment, color: Colors.white)),
            CurvedNavigationBarItem(
                child: Icon(Icons.link_rounded, color: Colors.white)),
            CurvedNavigationBarItem(
                child: Icon(Icons.person, color: Colors.white))
          ],
        ),
        appBar: AppBar(
          title: Text(
            pageTitles[index],
            style: TextStyle(
                color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
          ),
          elevation: 0,
          backgroundColor: Color.fromRGBO(244, 196, 48, 0.9),
          actions: [Icon(Icons.notifications_none_outlined)],
        ),
        drawer: CustomDrawer(),
        body: MultiBlocListener(
            listeners: [
              BlocListener<LogoutBloc, LogOutState>(listener: (context, state) {
                if (state is LoggedOut) {
                  Navigator.pushNamed(context, "/login");
                }
              }),
            ],
            child: IndexedStack(
              index: index,
              children: pagesList,
            )));
  }
}
