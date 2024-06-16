// import 'package:begara_mobile/feauters/auth/domain/Entities/userStatus.dart';
// import 'package:begara_mobile/feauters/auth/domain/repository/userStatusRepository.dart';
// import 'package:begara_mobile/feauters/auth/domain/usecases/get_user_status.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
//
// class MockUserStatusRepository extends Mock implements UserStatusRepository{}
//
// void main(){
// late GetUserStatus usecase;
// late MockUserStatusRepository mockRepo;
//
//   setUp((){
// mockRepo= MockUserStatusRepository();
// usecase= GetUserStatus(mockRepo);
//   });
//
//   final statusEntity= UserStatusEntity(profile_status:1, payment_status:0);
// String id= "1";
//
//   test("should get user status", () async{
//     when(mockRepo.getUserStatus(id)).thenAnswer(
//             (_) async => statusEntity);
//
//     final result= await usecase.call(id);
//     expect(result, statusEntity);
//     verify(mockRepo.getUserStatus(id));
//
//   });
// }

import 'package:begara_mobile/feauters/auth/domain/Entities/userStatus.dart';
import 'package:begara_mobile/feauters/auth/domain/repository/userStatusRepository.dart';
import 'package:begara_mobile/feauters/auth/domain/usecases/get_user_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
 // Replace with correct path to your entity

// Mock class
class MockUserStatusRepository extends Mock implements UserStatusRepository {}

void main() {
  late GetUserStatus usecase;
  late MockUserStatusRepository mockRepo;

  setUp(() {
    mockRepo = MockUserStatusRepository();
    usecase = GetUserStatus(mockRepo);
  });

  UserStatusEntity statusEntity = UserStatusEntity(profile_status: 0, payment_status: 1, );
  final String id = '1';  // Ensure ID is a String

  test('should get user status', () async {
    // Arrange
    when(mockRepo.getUserStatus(id)).thenAnswer(
          (_) async { return statusEntity;},
    );

    // Act
    final result = await usecase.call(id);

    // Assert
    expect(result, statusEntity);
    verify(mockRepo.getUserStatus(id)).called(1);
    verifyNoMoreInteractions(mockRepo);
  });
}
