
import 'package:begara_mobile/feauters/house/presentation/bloc/user/theme/theme_event.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';


class ThemeBloc extends Bloc<ThemeEvent, ThemeMode> {
  ThemeBloc() : super(ThemeMode.light){
    on<ThemeChange> ((event,emit){
      emit(event.isDark ? ThemeMode.dark: ThemeMode.light);
    });
  }
}
