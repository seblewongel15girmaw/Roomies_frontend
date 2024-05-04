import 'package:begara_mobile/core/platform/network_info.dart';
import 'package:begara_mobile/feauters/auth/data/data_source/user_data_sources.dart';
import 'package:begara_mobile/feauters/auth/data/data_source/user_local_data_sources.dart';
import 'package:begara_mobile/feauters/auth/data/repository/user_repository_impl.dart';
import 'package:begara_mobile/feauters/auth/domain/repository/userRepository.dart';
import 'package:begara_mobile/feauters/auth/domain/usecases/create_profile.dart';
import 'package:begara_mobile/feauters/auth/domain/usecases/login_user.dart';
import 'package:begara_mobile/feauters/auth/domain/usecases/register_user.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/login/login_bloc.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/profile/profile_bloc.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/register/register_bloc.dart';
import 'package:begara_mobile/feauters/recommendation/data/data_source/roommate_data_source.dart';
import 'package:begara_mobile/feauters/recommendation/data/repository/roommate_repository_impl.dart';
import 'package:begara_mobile/feauters/recommendation/domain/repository/roommate_repository.dart';
import 'package:begara_mobile/feauters/recommendation/domain/usecases/get_all_roommate.dart';
import 'package:begara_mobile/feauters/recommendation/presentation/bloc/roommate/roommate_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sl=GetIt.instance;
Future <void> init() async{
  final sharedPreferences= await SharedPreferences.getInstance();
  sl.registerFactory(() => LogBloc(sl()));
  sl.registerFactory(() => RegBloc(sl()));
  sl.registerFactory(() => ProfileBloc(sl()));
  sl.registerFactory(() => RoommateBloc(sl()));
  sl.registerLazySingleton(() => LoginUser(sl()));
  sl.registerLazySingleton(() => RegisterUser(sl()));
  sl.registerLazySingleton(() => CreateProfile(sl()));
  sl.registerLazySingleton(() => GetAllRoommates(sl()));
  sl.registerLazySingleton<UserRepo>(() => UserRepositoryImpl(sl(), sl(), sl()) );
  sl.registerLazySingleton<UserDataSources>(() => userDataSourcesImpl(sl()));
  sl.registerLazySingleton<UserLocalDataSources>(() => UserLocalDataSourcesImpl(sl()));
  sl.registerLazySingleton<RoommateRepository>(()=> RoommateRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<RoommateDataSource>(() => RoommateDataSourceImpl(sl()));
  sl.registerLazySingleton<Network>(() => NetworkImpl(sl()));
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => Connectivity());
  

}