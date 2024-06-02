import 'package:begara_mobile/feauters/auth/presentation/widgets/profile_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:begara_mobile/feauters/auth/domain/Entities/location.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/users_profile/user_profile.dart';
import 'dart:io';


class MyProfile extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserProfileBloc>(context).add(UserProfileEvent(0));

    XFile? image;
    XFile? image2;
    String fullName;
    String phoneNumber;
    String age ;
    String budget ;
    String? religion;
    Location? address;
    String gender ;
var width=MediaQuery.of(context).size.width;
  return Scaffold(
      body: BlocBuilder<UserProfileBloc,UserProfileState>(
      builder: (context,state) {
      if(state is UserProfileSuccess){
        final user= state.user;
        return ListView(
      children: [Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 80,
            color: Color.fromRGBO(255, 253,208,1),
          ),
          Positioned(
            top: 15,
            left: (width/2)-60,
            child: Container(
              height: 110,
              width: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(70),
                border: Border.all(color: Colors.white, width: 7)
              ),

              child: CircleAvatar(
                backgroundImage: FileImage(File(user.image)),
              ),
            ),
          )
        ],
      ),
SizedBox(height: 60,),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          padding: EdgeInsets.only(left: 20, top: 14,bottom: 14, right: 15),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
              color: Colors.black12,
                spreadRadius: 3,
                blurRadius: 12,
                offset: Offset(3, 3),
            ),],
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Profile_fields(title:"Full Name", value: user.fullName),
              Profile_fields(title:"User Name", value: user.userName),
              Profile_fields(title:"Email", value: user.email),
              Profile_fields(title:"Address", value: user.address.displayName),
              Profile_fields(title:"Age", value: user.age.toString()),
              Profile_fields(title:"Budget", value: user.budget.toString()),
              Profile_fields(title:"Job Status", value: user.jobStatus),
              Profile_fields(title:"Religion", value: user.religion),
              Profile_fields(title:"Gender", value: user.gender),
            ],
          ),
        ),
        SizedBox(height: 25),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: ElevatedButton(onPressed: (){
            Navigator.of(context).pushNamed("/edit-profile");
          },
              child: Text("Edit Profile")),
        ),
        SizedBox(height: 30),
      ]
    );
      }
      else{
        return Text("will be displayed when u fill the profile page");
      }
  })
  );
  }
}