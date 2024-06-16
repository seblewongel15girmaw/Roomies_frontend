import 'dart:io';

import 'package:begara_mobile/feauters/auth/presentation/bloc/others/image/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/util/env.dart';
import '../bloc/others/image/id_image.dart/id_image_bloc.dart';

import '../bloc/others/image/id_image.dart/id_image_state.dart';

class UploadImageButton extends StatelessWidget {
  XFile? idImage;
  final Function(BuildContext, dynamic) listener;
  void Function()? onPressed;
  UploadImageButton(
      {super.key,
      required this.idImage,
      required this.onPressed,
      required this.listener});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<IdImageBloc, IdState>(
      listener: (context, state) => listener(context, state),
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.all(10),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: Size(MediaQuery.of(context).size.width, 50),
              backgroundColor: state is IdSuccess? Color.fromARGB(255, 240, 222, 177): Color.fromARGB(255, 187, 148, 48),
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(0), // Adjust the value as needed
              ),
            ),
            onPressed: onPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[Icon(Icons.upload), SizedBox(width: 30,), state is IdSuccess?Padding(padding: EdgeInsets.all(5),child: Image.file(File(state.image!.path))) : idImage!=null?Padding(padding: EdgeInsets.all(5),child:Image.network("http://${ipAdress}:8000/${idImage!.path.split("\\").last}")) : Text("Upload Id")],
            ),
          ),
        );
      },
    );
  }
}
