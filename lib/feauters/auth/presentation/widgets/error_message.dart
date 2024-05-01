import 'package:begara_mobile/feauters/auth/presentation/bloc/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ErrorMessage extends StatelessWidget {
  final String image;
  const ErrorMessage({required this.image});
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is CreateFailed && state.causingImage==image) {
          return Text(state.error!, style: TextStyle(color: Colors.red));
        } else {
          return SizedBox();
        }
      },
      buildWhen: (context, state) {
        if (state is CreateFailed) {
          return true;
        } else {
          return false;
        }
      },
    );
  }
}
