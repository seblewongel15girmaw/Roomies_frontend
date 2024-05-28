import "package:begara_mobile/config/routes.dart";
import "package:begara_mobile/core/util/sharedPreference.dart";
import "package:begara_mobile/feauters/auth/presentation/bloc/login/login.dart";
import "package:begara_mobile/feauters/auth/presentation/bloc/others/censor/censor.dart";
import "package:begara_mobile/feauters/auth/presentation/bloc/others/image/image_bloc.dart";
import "package:begara_mobile/feauters/auth/presentation/bloc/profile/profile_bloc.dart";
import "package:begara_mobile/feauters/auth/presentation/bloc/register/register_bloc.dart";
import "package:begara_mobile/feauters/auth/presentation/pages/create_profile_page.dart";
import "package:begara_mobile/feauters/auth/presentation/pages/forgot_passowrd_page.dart";
import "package:begara_mobile/feauters/auth/presentation/pages/login_page.dart";
import "package:begara_mobile/feauters/auth/presentation/pages/register_guarantor_page.dart";
import "package:begara_mobile/feauters/auth/presentation/pages/registeration_page.dart";
import "package:begara_mobile/feauters/chat/presentation/blocs/contacts/contacts.dart";
import "package:begara_mobile/feauters/chat/presentation/pages/alternate_chat_page.dart";
import "package:begara_mobile/feauters/chat/presentation/pages/chat_page.dart";
import "package:begara_mobile/feauters/chat/presentation/pages/contacts_page.dart";
import "package:begara_mobile/feauters/house/presentation/page/user/home_page.dart";
import "package:begara_mobile/feauters/recommendation/presentation/bloc/roommate/roommate_bloc.dart";
import "package:begara_mobile/feauters/recommendation/presentation/pages/display_matches_page.dart";
import "package:begara_mobile/feauters/recommendation/presentation/pages/user_profile_page.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_test/flutter_test.dart";
import "package:get_it/get_it.dart";
import "package:integration_test/integration_test.dart";
import 'package:begara_mobile/main.dart' as app;
import 'package:begara_mobile/injectionContainer.dart';
import "package:mockito/mockito.dart";
import 'package:image_picker/image_picker.dart';

class MockRegisterBloc extends Mock implements RegBloc {}
class MockImagePicker extends Mock implements ImagePicker {}

void setupMockImagePicker(MockImagePicker mockImagePicker) {
  when(mockImagePicker.pickImage(source: ImageSource.gallery)).thenAnswer((_) async {
    return XFile('/path/to/test_image.png');
  });
}

void main(){
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  
  group("end to end", () {
    final getIt=GetIt.instance;

    setUp(() {
init();
    });

    tearDown(() {
      getIt.reset();
    });

    //
    // setUpAll(() async {
    //   if (getIt.isRegistered<LogBloc>()) {
    //     await getIt.reset();
    //   }
    //   await init();// Initialize your dependencies once
    // });
    //
    // tearDownAll(() async {
    //   if (getIt.isRegistered<LogBloc>()) {
    //     print("it is registered and cleared");
    //     await getIt.reset(); // Reset GetIt after all tests
    //   }
    // });


    testWidgets('verify if the form can be filled and submitted', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to the RegisterPage
      await tester.tap(find.byKey(Key('to_register_btn')));
      await tester.pumpAndSettle();

      // Verify if the RegisterPage is displayed
      expect(find.byType(RegisterPage), findsOneWidget);

      // Enter text in the Full Name field
      await tester.enterText(find.byKey(Key('reg_fullname')), 'John Doe');
      await tester.enterText(find.byKey(Key('reg_username')), 'johndoe');
      await tester.enterText(find.byKey(Key('reg_email')), 'johndoe@example.com');
      await tester.enterText(find.byKey(Key('reg_password')), 'Password123!');
      await tester.enterText(find.byKey(Key('reg_password2')), 'Password123!');

      // Submit the form
      await tester.tap(find.byKey(Key('register_btn')));
      await tester.pumpAndSettle();
      expect(find.byKey(Key("login_page")), findsOneWidget);
    });


    testWidgets("verify login page if token doesn't exits", (tester) async{
       await SharedPreferencesService.remove("token");
      app.main();
      await tester.pumpAndSettle();
       expect(find.byKey(Key("login_page")), findsOneWidget);
     await tester.enterText(find.byKey(Key("login_username")), "rut");
     await tester.enterText(find.byKey(Key("login_password")), "12345");
     await tester.tap(find.byKey(Key("login_btn")));
     await tester.pumpAndSettle();
       expect(find.byType(HomePage), findsOneWidget);
    }
    );

    testWidgets("verify home page redirection if token exist", (tester) async{
      await SharedPreferencesService.setString("token", "token data");
      app.main();
      await tester.pumpAndSettle();
      expect(find.byType(HomePage), findsOneWidget);
    });

    testWidgets('Complete Profile form and navigate to Guarantor Page', (WidgetTester tester) async {

      final Routes appRoutes = Routes();
      await tester.pumpWidget(
          MultiBlocProvider(
            providers: [
              BlocProvider<ProfileBloc>(
                create: (context) => sl<ProfileBloc>(),
              ),
              BlocProvider<ImageBloc>(
                create: (context) => ImageBloc(),
              ),
            ],
            child: MaterialApp(
              onGenerateRoute: appRoutes.generateRoute,
              home: ProfilePage(),
              initialRoute: "/profile", // Set ProfilePage as the home widget
            ),
          ));

      await tester.pumpAndSettle();

      // Verify ProfilePage is loaded
      expect(find.byType(ProfilePage), findsOneWidget);

      // Fill the form fields
      await tester.enterText(find.byKey(const Key('profile_phone')), '1234567890');
      await tester.enterText(find.byKey(const Key('profile_age')), '25');
      await tester.enterText(find.byKey(const Key('profile_budget')), '1000');
      await tester.enterText(find.byKey(const Key('profile_job')), 'Engineer');

      // Tap on the profile image upload button
      await tester.tap(find.byKey(const Key('profile_image_upload')));
      await tester.pumpAndSettle();

      // Select dropdown values (if using dropdown items)
      await tester.tap(find.byKey(const Key('profile_address')));
      await tester.pumpAndSettle();
      await tester.tap(find.text("Bole Subcity").last);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('profile_religion')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Orthodox Christian').last);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('gender_dropdown')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Male').last);
      await tester.pumpAndSettle();

      // Other dropdowns
      await tester.ensureVisible(find.byKey(const Key('profile_religious_similarity')));
      await tester.tap(find.byKey(const Key('profile_religious_similarity')));
      await tester.pumpAndSettle();
      await tester.tap(find.text("Yes, I'm open-minded.").last);
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.byKey(const Key('smoking')));
      await tester.tap(find.byKey(const Key('smoking')));
      await tester.pumpAndSettle();
      await tester.tap(find.text("I don't smoke").last);
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.byKey(const Key('pet')));
      await tester.tap(find.byKey(const Key('pet')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('No, I prefer not to live with pets.').last);
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.byKey(const Key('punctuality')));
      await tester.tap(find.byKey(const Key('punctuality')));
      await tester.pumpAndSettle();
      await tester.tap(find.text("Yes, I'm understanding.").last);
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.byKey(const Key('socialize')));
      await tester.tap(find.byKey(const Key('socialize')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Occasionally').last);
      await tester.pumpAndSettle();

      // Enter bio text
      await tester.ensureVisible(find.byKey(const Key('bio')));
      await tester.enterText(find.byKey(const Key('bio')), 'I love coding and outdoor activities.');

      // Tap on the ID image upload button
      await tester.ensureVisible(find.byKey(const Key('profile_id_upload')));
      await tester.tap(find.byKey(const Key('profile_id_upload')));
      await tester.pumpAndSettle();
      // This would open the image picker. Assume the image is picked.

      // Submit the form
      await tester.ensureVisible(find.byKey(const Key('profile_btn')));
      await tester.tap(find.byKey(const Key('profile_btn')));
      await tester.pumpAndSettle();

      // Verify navigation to GuarantorPage
      expect(find.byType(RegisterGuarantorPage), findsOneWidget);
    });

    testWidgets("recover Password",(WidgetTester tester) async{
      final Routes appRoutes = Routes();
      await tester.pumpWidget(
          MultiBlocProvider(
            providers: [
              BlocProvider<LogBloc>(
                create: (context) => sl<LogBloc>(),
              ),
             BlocProvider<PassBloc>(
                create: (context) => PassBloc(),
              ),
            ],
            child: MaterialApp(
              onGenerateRoute: appRoutes.generateRoute,
              home: LoginPage(),
              initialRoute: "/login",
            ),
          ));
      
      // Load the login page
      await tester.pumpAndSettle();
      expect(find.byType(LoginPage), findsOneWidget);
      // Navigate to forgot password page
      await tester.tap(find.byKey(Key("forget")));
      await tester.pumpAndSettle();
      expect(find.byType(ForgotPasswordPage),findsOneWidget);
      //Enter recovery email and press recover
      await tester.enterText(find.byType(TextFormField),"abebe@gmail.com");
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      expect(find.text("Your password has been recovered. Please login using your new password"),findsOneWidget);
    });

    testWidgets("get possible matches and send message", (WidgetTester tester) async{
      final Routes appRoutes = Routes();
      await tester.pumpWidget(
          MultiBlocProvider(
            providers: [
              BlocProvider<RoommateBloc>(
                create: (context) => sl<RoommateBloc>(),
              ),
             
            ],
            child: MaterialApp(
              onGenerateRoute: appRoutes.generateRoute,
              home: DisplayMatchesPage(),
              initialRoute: "/roommate",
            ),
          ));
      // Load the Recommended users
      await tester.pumpAndSettle();
      expect(find.byType(DisplayMatchesPage), findsOneWidget);
      // navigate to the choosen candidate profile
      await tester.tap(find.byType(GestureDetector).first);
      await tester.pumpAndSettle();
      expect(find.byType(UserProfilePage),findsOneWidget);
      // click the chat icon
      await tester.tap(find.byType(IconButton).first);
      await tester.pumpAndSettle();
      expect(find.byType(AlternateChatPage),findsOneWidget);
      // Write some message and hit send
      await tester.enterText(find.byType(TextField), "for__@testpurpose@__");
      await tester.tap(find.byKey(Key("send_message")));
      await tester.pumpAndSettle();
      expect(find.text("for__@testpurpose@__"),findsOneWidget);
    });

    
  }
  );

}