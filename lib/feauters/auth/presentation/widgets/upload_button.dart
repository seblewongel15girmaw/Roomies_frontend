import 'package:begara_mobile/feauters/auth/presentation/bloc/others/image/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

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
    return BlocConsumer<ImageBloc, ImageState>(
      listener: (context, state) => listener(context, state),
      builder: (context, state) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: Size(500, 60),
            backgroundColor: Color.fromARGB(255, 187, 148, 48),
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(0), // Adjust the value as needed
            ),
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Icon(Icons.upload), Text("Upload Id")],
          ),
        );
      },
    );
  }
}
