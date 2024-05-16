import 'package:begara_mobile/core/platform/network_info.dart';
import 'package:begara_mobile/feauters/auth/data/data_source/guarantor_data_sources.dart';
import 'package:begara_mobile/feauters/auth/data/data_source/user_data_sources.dart';
import 'package:begara_mobile/feauters/auth/data/data_source/user_local_data_sources.dart';
import 'package:begara_mobile/feauters/auth/data/repository/guarantor_repository_impl.dart';
import 'package:begara_mobile/feauters/auth/data/repository/user_repository_impl.dart';
import 'package:begara_mobile/feauters/auth/domain/repository/guarantorRepository.dart';
import 'package:begara_mobile/feauters/auth/domain/repository/userRepository.dart';
import 'package:begara_mobile/feauters/auth/domain/usecases/create_guarantor.dart';
import 'package:begara_mobile/feauters/auth/domain/usecases/create_profile.dart';
import 'package:begara_mobile/feauters/auth/domain/usecases/login_user.dart';
import 'package:begara_mobile/feauters/auth/domain/usecases/register_user.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/guarantor/guarantor_bloc.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/login/login_bloc.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/profile/profile_bloc.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/register/register_bloc.dart';
import 'package:begara_mobile/feauters/chat/data/data_source/chat_data_source.dart';
import 'package:begara_mobile/feauters/chat/data/data_source/live_data_source.dart';
import 'package:begara_mobile/feauters/chat/data/repository/chat_repository_impl.dart';
import 'package:begara_mobile/feauters/chat/data/repository/live_repository.dart';
import 'package:begara_mobile/feauters/chat/domain/repository/chatRepository.dart';
import 'package:begara_mobile/feauters/chat/domain/repository/live_repository.dart';
import 'package:begara_mobile/feauters/chat/domain/usecase/get_chats.dart';
import 'package:begara_mobile/feauters/chat/domain/usecase/get_contacts.dart';
import 'package:begara_mobile/feauters/chat/domain/usecase/live_use_case.dart';
import 'package:begara_mobile/feauters/chat/domain/usecase/save_chats.dart';
import 'package:begara_mobile/feauters/chat/presentation/blocs/chat_history/chat_history_bloc.dart';
import 'package:begara_mobile/feauters/chat/presentation/blocs/contacts/contacts_bloc.dart';
import 'package:begara_mobile/feauters/chat/presentation/blocs/live_Chat/live_chat_bloc.dart';
import 'package:begara_mobile/feauters/chat/presentation/blocs/new_chat/new_chat_bloc.dart';
import 'package:begara_mobile/feauters/recommendation/data/data_source/roommate_data_source.dart';
import 'package:begara_mobile/feauters/recommendation/data/repository/roommate_repository_impl.dart';
import 'package:begara_mobile/feauters/recommendation/domain/repository/roommate_repository.dart';
import 'package:begara_mobile/feauters/recommendation/domain/usecases/get_all_roommate.dart';
import 'package:begara_mobile/feauters/recommendation/domain/usecases/get_roommate.dart';
import 'package:begara_mobile/feauters/recommendation/presentation/bloc/roommate/roommate_bloc.dart';
import 'package:begara_mobile/feauters/recommendation/presentation/bloc/users_profile/users_profile_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as IO;

final sl=GetIt.instance;
Future <void> init() async{
  final sharedPreferences= await SharedPreferences.getInstance();
  final socket = IO.io('http://localhost:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
  sl.registerFactory(() => LogBloc(sl()));
  sl.registerFactory(() => RegBloc(sl()));
  sl.registerFactory(() => ProfileBloc(sl()));
  sl.registerFactory(() => RoommateBloc(sl()));
  sl.registerFactory(() => UserProfileBloc(sl()));
  sl.registerFactory(() => GuarantorBloc(sl()));
  sl.registerFactory(() => LiveChatBloc(sl()));
  sl.registerFactory(() => ChatHistoryBloc(sl()));
  sl.registerFactory(() => ContactsBloc(sl()));
  sl.registerFactory(() => LiveBloc(sl()));
  sl.registerFactory<InstantiateBloc>(() => InstantiateBloc(sl()));
  sl.registerLazySingleton(() => LoginUser(sl()));
  sl.registerLazySingleton(() => RegisterUser(sl()));
  sl.registerLazySingleton(() => CreateProfile(sl()));
  sl.registerLazySingleton(() => GetAllRoommates(sl()));
  sl.registerLazySingleton(() => GetRoommate(sl()));
  sl.registerLazySingleton(() => CreateGuarantor(sl()));
  sl.registerLazySingleton(() => GetChats(sl()));
  sl.registerLazySingleton(() => GetContacts(sl()));
  sl.registerLazySingleton(() => SaveChats(sl()));
  sl.registerLazySingleton(() => ConnectUseCase(sl()));
  sl.registerLazySingleton(() => SendMessageUseCase(sl()));
  sl.registerLazySingleton<UserRepo>(() => UserRepositoryImpl(sl(), sl(), sl()) );
  sl.registerLazySingleton<UserDataSources>(() => userDataSourcesImpl(sl()));
  sl.registerLazySingleton<UserLocalDataSources>(() => UserLocalDataSourcesImpl(sl()));
  sl.registerLazySingleton<RoommateRepository>(()=> RoommateRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<RoommateDataSource>(() => RoommateDataSourceImpl(sl()));
  sl.registerLazySingleton<GuarantorRepo>(()=> GuarantorRepoImpl(sl(), sl()));
  sl.registerLazySingleton<GuarantorDataSource>(() => GuarantorDataSourceImpl(sl()));
  sl.registerLazySingleton<ChatRepo>(()=> ChatRepoImpl(sl(), sl()));
  sl.registerLazySingleton<ChatDataSources>(() => ChatDataSourcesImpl(sl()));
  sl.registerLazySingleton<LiveRepository>(()=> LiveRepositoryImpl(sl()));
  sl.registerLazySingleton<SocketDataProvider>(() => SocketDataProviderImpl(sl()));
  sl.registerLazySingleton<Network>(() => NetworkImpl(sl()));
  sl.registerLazySingleton(() => socket);
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => Connectivity());
  
  

}