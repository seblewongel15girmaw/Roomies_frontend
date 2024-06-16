import 'package:begara_mobile/core/platform/network_info.dart';
import 'package:begara_mobile/feauters/auth/data/data_source/guarantor_data_sources.dart';
import 'package:begara_mobile/feauters/auth/data/data_source/userStatus_data_source.dart';
import 'package:begara_mobile/feauters/auth/data/data_source/user_data_sources.dart';
import 'package:begara_mobile/feauters/auth/data/data_source/user_local_data_sources.dart';
import 'package:begara_mobile/feauters/auth/data/repository/guarantor_repository_impl.dart';
import 'package:begara_mobile/feauters/auth/data/repository/userStatus_repository_impl.dart';
import 'package:begara_mobile/feauters/auth/data/repository/user_repository_impl.dart';
import 'package:begara_mobile/feauters/auth/domain/repository/guarantorRepository.dart';
import 'package:begara_mobile/feauters/auth/domain/repository/userRepository.dart';
import 'package:begara_mobile/feauters/auth/domain/repository/userStatusRepository.dart';
import 'package:begara_mobile/feauters/auth/domain/usecases/create_guarantor.dart';
import 'package:begara_mobile/feauters/auth/domain/usecases/create_profile.dart';
import 'package:begara_mobile/feauters/auth/domain/usecases/get_user_status.dart';
import 'package:begara_mobile/feauters/auth/domain/usecases/login_user.dart';
import 'package:begara_mobile/feauters/auth/domain/usecases/register_user.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/deactivate/deactivate.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/guarantor/guarantor_bloc.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/login/login_bloc.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/logout/logout.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/profile/profile_bloc.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/register/register_bloc.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/user_status/user_status_bloc.dart';
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
import 'package:begara_mobile/feauters/house/data/datasource/user/payment_remote_datasource.dart';
import 'package:begara_mobile/feauters/house/data/repository/user/payment_repository_impl.dart';
import 'package:begara_mobile/feauters/house/domain/usecase/user/checkPaymentStatus.dart';
import 'package:begara_mobile/feauters/house/domain/usecase/user/filterHouse.dart';
import 'package:begara_mobile/feauters/house/domain/usecase/user/get_broker_profile.dart';
import 'package:begara_mobile/feauters/house/domain/usecase/user/makePayment.dart';
import 'package:begara_mobile/feauters/house/presentation/bloc/user/payment/payment_bloc.dart';
import 'package:begara_mobile/feauters/recommendation/data/data_source/roommate_data_source.dart';
import 'package:begara_mobile/feauters/recommendation/data/repository/roommate_repository_impl.dart';
import 'package:begara_mobile/feauters/recommendation/domain/repository/roommate_repository.dart';
import 'package:begara_mobile/feauters/recommendation/domain/usecases/get_all_roommate.dart';
import 'package:begara_mobile/feauters/recommendation/domain/usecases/get_roommate.dart';
import 'package:begara_mobile/feauters/recommendation/presentation/bloc/roommate/roommate_bloc.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'core/util/env.dart';
import 'feauters/auth/domain/usecases/change_password.dart';
import 'feauters/auth/domain/usecases/get_locations.dart';
import 'feauters/auth/domain/usecases/logout_user.dart';
import 'feauters/auth/domain/usecases/recover_password.dart';
import 'feauters/auth/domain/usecases/unsubscribe_user.dart';
import 'feauters/auth/presentation/bloc/change_password/change_password.dart';
import 'feauters/auth/presentation/bloc/location/locations.dart';
import 'feauters/auth/presentation/bloc/recover_password/recover_password.dart';
import 'feauters/auth/presentation/bloc/users_profile/user_profile.dart';
import 'feauters/feedback/data/data_source/feedback_data_source.dart';
import 'feauters/feedback/data/repository/feedback_repository_impl.dart';
import 'feauters/feedback/domain/repository/feedback_repository.dart';
import 'feauters/feedback/domain/usecases/give_feedback.dart';
import 'feauters/feedback/presentation/blocs/feedback/feedback_bloc.dart';
import 'feauters/house/data/datasource/user/house_remote_datasource.dart';
import 'feauters/house/data/repository/user/house_repository_impl.dart';
import 'feauters/house/domain/repository/user/house_repository.dart';
import 'feauters/house/domain/repository/user/payment_repository.dart';
import 'feauters/house/domain/usecase/user/get_house_list.dart';
import 'feauters/house/presentation/bloc/user/house/house_bloc.dart';

final sl=GetIt.instance;
Future <void> init() async{
  final sharedPreferences= await SharedPreferences.getInstance();
  final socket = IO.io('http://${ipAdress}:3000', <String, dynamic>{
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
  sl.registerFactory(() => LiveBloc(sl(),sl()));
  sl.registerFactory(()=>UserStatusBloc(sl()));
  sl.registerFactory(() => RecoverPasswordBloc(sl()));
  sl.registerFactory(() => ChangePasswordBloc(sl()));
  sl.registerFactory<InstantiateBloc>(() => InstantiateBloc(sl()));
  sl.registerFactory(() => FeedBackBloc(sl()));
  sl.registerFactory(() => LocationBloc(sl()));
  sl.registerFactory(() => HouseBloc(sl(), sl(), sl()));
  sl.registerFactory(() => LogoutBloc(sl()));
  sl.registerFactory(()=>DeactivateBloc(sl()));
  sl.registerFactory(()=> PaymentBloc(sl(), sl()));
  sl.registerLazySingleton(() => LoginUser(sl()));
  sl.registerLazySingleton(() => RegisterUser(sl()));
  sl.registerLazySingleton(() => CreateProfile(sl()));
  sl.registerLazySingleton(() => GetAllRoommates(sl()));
  sl.registerLazySingleton(() => GetRoommate(sl()));
  sl.registerLazySingleton(() => CreateGuarantor(sl()));
  sl.registerLazySingleton(() => GetChats(sl()));
  sl.registerLazySingleton(() => GetContacts(sl()));
  sl.registerLazySingleton(() => GetHouseList(sl()));
  sl.registerLazySingleton(()=>FilterHouse(sl()));
  sl.registerLazySingleton(() => SaveChats(sl()));
  sl.registerLazySingleton(()=>GetUserStatus(sl()));
  sl.registerLazySingleton(() => ConnectUseCase(sl()));
  sl.registerLazySingleton(() => SendMessageUseCase(sl()));
  sl.registerLazySingleton(() => RecoverPassword(sl()));
  sl.registerLazySingleton(() => ChangePassword(sl()));
  sl.registerLazySingleton(() => GiveFeedback(sl()));
  sl.registerLazySingleton(() => GetLocations(sl()));
  sl.registerLazySingleton(()=>LogOutUser(sl()));
  sl.registerLazySingleton(()=> GetBrokerProfile(sl()));
  sl.registerLazySingleton(()=>UnsubscribeUser(sl()));
  sl.registerLazySingleton(()=> MakePayment(sl()));
  sl.registerLazySingleton(()=> CheckPaymentStatus(sl()));
  sl.registerLazySingleton(()=> GetBrokerProfile(sl()));
  sl.registerLazySingleton<UserRepo>(() => UserRepositoryImpl(sl(), sl(), sl()) );
  sl.registerLazySingleton<UserStatusRepository>(()=> UserStatusRepoImpl(sl()));
  sl.registerLazySingleton<UserDataSources>(() => userDataSourcesImpl(sl()));
  sl.registerLazySingleton<UserLocalDataSources>(() => UserLocalDataSourcesImpl(sl()));
  sl.registerLazySingleton<HouseRepository>(() => HouseRepositoryImpl(houseRemoteDatasource: sl()));
  sl.registerLazySingleton<RoommateRepository>(()=> RoommateRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<RoommateDataSource>(() => RoommateDataSourceImpl(sl()));
  sl.registerLazySingleton<UserStatusDataSource>(()=> UserStatusDataSourceImpl(sl()));
  sl.registerLazySingleton<HouseRemoteDatasource>(() => HouseRemoteDatasourceImpl(client: sl()));
  sl.registerLazySingleton<GuarantorRepo>(()=> GuarantorRepoImpl(sl(), sl()));
  sl.registerLazySingleton<GuarantorDataSource>(() => GuarantorDataSourceImpl(sl()));
  sl.registerLazySingleton<ChatRepo>(()=> ChatRepoImpl(sl(), sl()));
  sl.registerLazySingleton<ChatDataSources>(() => ChatDataSourcesImpl(sl()));
  sl.registerLazySingleton<LiveRepository>(()=> LiveRepositoryImpl(sl()));
  sl.registerLazySingleton<SocketDataProvider>(() => SocketDataProviderImpl(sl()));
  sl.registerLazySingleton<FeedBackRepo>(()=> FeedBackRepoImpl(sl(),sl()));
  sl.registerLazySingleton<FeedbackDataSource>(() => FeedbackDataSourceImpl(sl()));
  sl.registerLazySingleton<PaymentRepository>(()=> PaymentRepositoryImpl(paymentRemoteDatasource: sl()));
  sl.registerLazySingleton<PaymentRemoteDatasource>(()=>PaymentRemoteDatasourceImpl(sl()));

  sl.registerLazySingleton<Network>(() => NetworkImpl(sl()));
  sl.registerLazySingleton(() => socket);
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => Connectivity());

}