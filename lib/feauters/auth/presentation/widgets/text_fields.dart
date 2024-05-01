import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/others/censor/censor.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData prefixIcon;
  final Color prefixIconColor;
  final FormFieldValidator<String>? validator;
  const CustomTextField({super.key, 
    required this.controller,
    required this.labelText,
    required this.prefixIcon,
    this.validator,
    this.prefixIconColor = const Color.fromARGB(255, 187, 148, 48),
 
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        
        prefixIcon: Icon(prefixIcon),
        prefixIconColor: prefixIconColor,
        labelText: labelText,
      ),
    );
  }
}

class PasswordFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final FormFieldValidator<String>? validator;

  const PasswordFormField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PassBloc, PassState>(
      builder: (context, state) {
        return TextFormField(
          validator: validator ,
          obscureText: state is Hidden,
          controller: controller,
          decoration: InputDecoration(
            label: Text(labelText),
            prefixIcon: const Icon(
              Icons.lock,
              color: Color.fromARGB(255, 187, 148, 48), // Constant prefix icon color
            ),
            suffix: GestureDetector(
              onTap: () {
                BlocProvider.of<PassBloc>(context).add(PassEvent());
              },
              child: state is Hidden
                  ? Icon(Icons.visibility)
                  : Icon(Icons.visibility_off),
            ),
          ),
        );
      },
    );
  }

  
}