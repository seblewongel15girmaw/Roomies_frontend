import 'dart:io';

import 'package:begara_mobile/feauters/auth/presentation/bloc/image_bloc.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/image_event.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/image_state.dart';
import 'package:begara_mobile/feauters/auth/presentation/widgets/profileform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatelessWidget{
  XFile? image;
  bool profileSelected=false;
  bool idSelected=false;
  @override
  Widget build(context){
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget> [
            SizedBox(
              height: 50,
            ),
           ProfileForm()
          ],
        ),
      ),
    );
  }
}