import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubmitButton extends StatelessWidget {
  final Bloc bloc;
  final Function onPressed;
  final String buttonText;
  final Function(BuildContext, dynamic) listener;
  final dynamic success;
  final dynamic fail;
  final dynamic progress;
  const SubmitButton({
    Key? key,
    required this.bloc,
    required this.onPressed,
    required this.buttonText,
    required this.listener,
    required this.success,
    required this.fail,
    required this.progress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: bloc,
      listener: (context, state) => listener(context, state),
      builder: (context, state) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: Size(200, 20),
            backgroundColor: _getBackgroundColor(state),
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0), // Adjust the value as needed
            ),
          ),
          onPressed: () {
          
              onPressed();
            
          },
          child: _buildButtonContent(state),
        );
      },
    );
  }

  Color _getBackgroundColor(dynamic state) {
    if (state == progress) {
      return Colors.grey;
    } else if (state == success) {
      return Colors.green;
    } else if (state == fail) {
      return Colors.red;
    }
    return Color.fromARGB(255, 187, 148, 48); // Default color
  }

  Widget _buildButtonContent(dynamic state) {
    if (state == progress) {
      return CircularProgressIndicator();
    } else if (state == success) {
      return Text("Success");
    } else if (state == fail) {
      return Text("Failed");
    }
    return Text(buttonText);
  }
}