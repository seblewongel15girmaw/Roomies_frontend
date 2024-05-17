import 'dart:developer';

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

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState()=> _HomePageState();
}

class _HomePageState extends State<HomePage>{

  @override
  void initState(){
    super.initState();
    houseBloc.add(InitialEvent());
}

  HouseBloc houseBloc= sl<HouseBloc>();
  @override
  Widget build(BuildContext context){
    List images=[
      "https://image.cnbcfm.com/api/v1/image/103500764-GettyImages-147205632-2.jpg?v=1691157601",
      "https://static.vecteezy.com/system/resources/thumbnails/023/308/053/small_2x/ai-generative-exterior-of-modern-luxury-house-with-garden-and-beautiful-sky-photo.jpg",
      "https://www.redfin.com/blog/wp-content/uploads/2021/08/220-Maryland-Ave-21122-1.jpg"];

    double width=MediaQuery.of(context).size.width;
    var index;
    final imageList=[
      "https://cdni.iconscout.com/illustration/premium/thumb/dormitory-roommates-3888852-3391090.png?f=webp",
      "https://img.freepik.com/premium-photo/reminder-notification-message-alert_902106-3.jpg",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQSf9_eWDsUTlYnJZeGarBE14TFiZ1W-KS1_lk6jwRyow&s"
    ];
    return Scaffold(
          backgroundColor: Colors.black87,
          bottomNavigationBar: CurvedNavigationBar(
            backgroundColor: Colors.black,
            color: Colors.white24,
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
            elevation: 0,
            backgroundColor: Color.fromRGBO(244, 196, 48,0.9),
            actions: [Icon(Icons.star_border_outlined)],
          ),
          drawer: Drawer(
            backgroundColor: Colors.black,
            child: ListView(
              children: const [
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
                  title: Text("Theme", style: TextStyle(fontSize: 13)),
                ),
                ListTile(
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  leading: Icon(Icons.help),
                  title: Text("Help", style: TextStyle(fontSize: 13)),
                ),
                ListTile(
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  leading: Icon(Icons.info),
                  title: Text("About Us", style: TextStyle(fontSize: 13)),
                ),
                ListTile(
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  leading: Icon(Icons.logout),
                  title: Text("Sign Out", style: TextStyle(fontSize: 13)),
                ),
              ],
            ),
          ),
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
                         width: width*0.8,
                         child: Column(
                           children: [
                             Container(
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
                                     child: Text("Please Fill In Your ",
                                         style:GoogleFonts.pressStart2p(
                                           color: Colors.white, fontSize: 9,
                                         )),
                                     // top:93,
                                     // left:width*0.23
                                   ) ,

                                   Container(
                                     child: Text("Profile Information",
                                         style:GoogleFonts.pressStart2p(
                                           color: Colors.white, fontSize: 9,
                                         )),
                                     // top:114,
                                     //     left:width*0.22
                                   )
                                 ],
                               ),
                             ),
                             SizedBox(height: 16,),
                             Container(
                               padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                               decoration: BoxDecoration(
                                   border: Border.all(color: Colors.red,),
                                   borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomLeft:Radius.circular(20),)
                               ),
                               child: TextButton(child: Text("Fill your profile by clicking here", style: TextStyle(color: Colors.white,fontSize: 11), ), onPressed: () {
                                 Navigator.of(context).pushNamed("/profile");
                               },),
                             ),
                             SizedBox(height: 30,),

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


