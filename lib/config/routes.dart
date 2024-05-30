import 'package:begara_mobile/feauters/auth/presentation/bloc/guarantor/guarantor_bloc.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/login/login_bloc.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/others/censor/censor_bloc.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/others/dropDown/dropdown.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/others/image/image_bloc.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/others/radioOptions/radio_bloc.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/profile/profile_bloc.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/register/register_bloc.dart';
import 'package:begara_mobile/feauters/auth/presentation/pages/login_page.dart';
import 'package:begara_mobile/feauters/auth/presentation/pages/create_profile_page.dart';
import 'package:begara_mobile/feauters/auth/presentation/pages/register_guarantor_page.dart';
import 'package:begara_mobile/feauters/auth/presentation/pages/registeration_page.dart';
import 'package:begara_mobile/feauters/chat/presentation/blocs/chat_history/chat_history_bloc.dart';
import 'package:begara_mobile/feauters/chat/presentation/blocs/contacts/contacts_bloc.dart';
import 'package:begara_mobile/feauters/chat/presentation/blocs/live_Chat/live_chat_bloc.dart';
import 'package:begara_mobile/feauters/chat/presentation/blocs/new_chat/new_chat_bloc.dart';
import 'package:begara_mobile/feauters/chat/presentation/pages/alternate_chat_page.dart';
import 'package:begara_mobile/feauters/chat/presentation/pages/chat_page.dart';
import 'package:begara_mobile/feauters/chat/presentation/pages/contacts_page.dart';
import 'package:begara_mobile/feauters/house/data/model/house_model.dart';
import 'package:begara_mobile/feauters/house/presentation/bloc/user/house/house_bloc.dart';
import 'package:begara_mobile/feauters/house/presentation/page/broker/broker_profile.dart';
import 'package:begara_mobile/feauters/house/presentation/page/user/home_page.dart';
import 'package:begara_mobile/feauters/house/presentation/page/user/house_detail.dart';
import 'package:begara_mobile/feauters/recommendation/presentation/bloc/roommate/roommate_bloc.dart';
import 'package:begara_mobile/feauters/recommendation/presentation/pages/display_matches_page.dart';
import 'package:begara_mobile/feauters/recommendation/presentation/pages/user_profile_page.dart';
import 'package:begara_mobile/injectionContainer.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../feauters/auth/presentation/bloc/change_password/change_password.dart';
import '../feauters/auth/presentation/bloc/location/locations.dart';
import '../feauters/auth/presentation/bloc/recover_password/recover_password.dart';
import '../feauters/auth/presentation/bloc/users_profile/users_profile_bloc.dart';
import '../feauters/auth/presentation/pages/change_password_page.dart';
import '../feauters/auth/presentation/pages/edit_profile_page.dart';
import '../feauters/auth/presentation/pages/forgot_passowrd_page.dart';
import '../feauters/feedback/presentation/blocs/chip/chip.dart';
import '../feauters/feedback/presentation/blocs/feedback/feedback_bloc.dart';
import '../feauters/feedback/presentation/pages/feedback_page.dart';

class Routes{

  Route<dynamic> generateRoute(RouteSettings settings){
    
    switch(settings.name){
      case '/login':
      return MaterialPageRoute(
        builder: (_)=>MultiBlocProvider(providers: [
        BlocProvider<PassBloc>(create: (context)=>PassBloc()),
        BlocProvider<LogBloc>(create: (context)=>sl<LogBloc>()),
       ],
        child: LoginPage(),
        ),
      );

      case '/register':
      
      return MaterialPageRoute(builder: (_)=>MultiBlocProvider(providers: [
        BlocProvider<PassBloc>(create: (context)=>PassBloc()),
        BlocProvider<RegBloc>(create: (context) =>sl<RegBloc>() ),
        ],
        child: RegisterPage(),
        ),);

      case '/profile':
      return MaterialPageRoute(builder: (_)=>MultiBlocProvider(providers: [
        BlocProvider<DropDownBloc>(create: (context) => DropDownBloc()) ,
        BlocProvider<ImageBloc>(create: (context) => ImageBloc()) ,
        BlocProvider<RadioBloc>(create: (context) => RadioBloc()) ,
        BlocProvider<LocationBloc>(create: (context) =>sl<LocationBloc>()),
        BlocProvider<ProfileBloc>(create: (context) =>sl<ProfileBloc>())],
        child: ProfilePage(),
        ),);
      case '/edit-profile':
      return MaterialPageRoute(builder: (_)=>MultiBlocProvider(providers: [
        BlocProvider<UserProfileBloc>(create: (context) =>sl<UserProfileBloc>()),
        BlocProvider<DropDownBloc>(create: (context) => DropDownBloc()) ,
        BlocProvider<ImageBloc>(create: (context) => ImageBloc()) ,
        BlocProvider<RadioBloc>(create: (context) => RadioBloc()) ,
        BlocProvider<ProfileBloc>(create: (context) =>sl<ProfileBloc>()),
        BlocProvider<LocationBloc>(create: (context) =>sl<LocationBloc>()),
        ],
        child: EditProfilePage(),
        ),);

      case '/guarantor':
      return MaterialPageRoute(builder: (_)=>MultiBlocProvider(providers: [
        BlocProvider<DropDownBloc>(create: (context) => DropDownBloc()) ,
        BlocProvider<ImageBloc>(create: (context) => ImageBloc()) ,
        BlocProvider<RadioBloc>(create: (context) => RadioBloc()) ,
        BlocProvider<GuarantorBloc>(create: (context) =>sl<GuarantorBloc>()),
        BlocProvider<LocationBloc>(create: (context) =>sl<LocationBloc>()),
        BlocProvider<ProfileBloc>(create: (context) =>sl<ProfileBloc>())],
        child: RegisterGuarantorPage(),
        ),);

      case '/roommate':
      return MaterialPageRoute(builder: (_)=>MultiBlocProvider(providers: [
        BlocProvider<RoommateBloc>(create: (context) => sl<RoommateBloc>()) ,],
        child: DisplayMatchesPage() ,
        ),);
       case '/matchprofile':
       final args=settings.arguments as Map<String,dynamic>;
      return MaterialPageRoute(builder: (_)=>MultiBlocProvider(providers: [
        BlocProvider<UserProfileBloc>(create: (context) => sl<UserProfileBloc>()) ,],
        child: UserProfilePage(user: args["roommates"],userId: args["userId"],) ,
        ),);
      
      case '/chat':
      final args=settings.arguments as Map<String,dynamic>;
      return MaterialPageRoute(
        builder: (_)=>MultiBlocProvider(providers: [
        BlocProvider<PassBloc>(create: (context)=>PassBloc()),
        BlocProvider<LiveChatBloc>(create: (context)=>sl<LiveChatBloc>()),
        BlocProvider<ChatHistoryBloc>(create:(context)=>sl<ChatHistoryBloc>())
        
       ],
        child: ChatPage(user: args["user"],userId: args["userId"],),
        ),
      );
      
      case '/chats':
      final args=settings.arguments as Map<String,dynamic>;
      return MaterialPageRoute(
        builder: (_)=>MultiBlocProvider(providers: [
        BlocProvider<PassBloc>(create: (context)=>PassBloc()),
        BlocProvider<LiveBloc>(create: (context)=>sl<LiveBloc>()),
        BlocProvider<InstantiateBloc>(create: (context)=>sl<InstantiateBloc>()),
        BlocProvider<ChatHistoryBloc>(create:(context)=>sl<ChatHistoryBloc>())
        
       ],
        child: AlternateChatPage(user: args["user"],userId: args["userId"],),
        ),
      );

      case '/contacts':
      return MaterialPageRoute(
        builder: (_)=>MultiBlocProvider(providers: [
        BlocProvider<ContactsBloc>(create: (context)=>sl<ContactsBloc>()),
       ],
        child: ContactsPage(),
        ),
      );

       case '/homePage':
      return MaterialPageRoute(
        builder: (_)=>MultiBlocProvider(providers: [
        BlocProvider<LocationBloc>(create: (context) =>sl<LocationBloc>()),
        BlocProvider<HouseBloc>(create: (context)=>sl<HouseBloc>()),
       ],
        child: HomePage(),
        )
      );

       case '/houseDetail':
         var args= settings.arguments as HouseModel;
      return MaterialPageRoute(
        builder: (_)=>MultiBlocProvider(providers: [
          BlocProvider<HouseBloc>(create: (context)=>sl<HouseBloc>()),
       ],
        child: HouseDetail(houseModel: args,),
        ),
      );

      case '/brokerDetail':
      return MaterialPageRoute(
        builder: (_)=>
            MultiBlocProvider(providers: [
        // BlocProvider<ContactsBloc>(create: (context)=>sl<ContactsBloc>()),
       ],
        child: BrokerProfile(),
        ),
      );

      case '/forget-password':
      return MaterialPageRoute(
        builder: (_)=>MultiBlocProvider(providers: [
        BlocProvider<RecoverPasswordBloc>(create: (context)=>sl<RecoverPasswordBloc>()),
       ],
        child: ForgotPasswordPage(),
        ),
      );

      case '/change-password':
      return MaterialPageRoute(
        builder: (_)=>MultiBlocProvider(providers: [
        BlocProvider<PassBloc>(create: (context)=>PassBloc()),
        BlocProvider<ChangePasswordBloc>(create: (context)=>sl<ChangePasswordBloc>()),
       ],
        child: ChangePasswordPage(),
        ),
      );
      case '/give-feedback':
      return MaterialPageRoute(
        builder: (_)=>MultiBlocProvider(providers: [
        BlocProvider<PassBloc>(create: (context)=>PassBloc()),
        BlocProvider<ChipBloc>(create: (context)=>ChipBloc()),
        BlocProvider<ChangePasswordBloc>(create: (context)=>sl<ChangePasswordBloc>()),
        BlocProvider<FeedBackBloc>(create: (context)=>sl<FeedBackBloc>()),
       ],
        child: FeedbackPage(),
        ),
      );

      default:
      return MaterialPageRoute(
        builder: (_)=>MultiBlocProvider(providers: [
        BlocProvider<PassBloc>(create: (context)=>PassBloc()),
        BlocProvider<LogBloc>(create: (context)=>sl<LogBloc>()),
       ],
        child: LoginPage(),
        ),
      );
    }

  }
}