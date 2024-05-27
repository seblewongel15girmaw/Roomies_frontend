import 'package:begara_mobile/core/error/errors.dart';
import 'package:begara_mobile/core/usecase/usecase.dart';
import 'package:begara_mobile/feauters/feedback/domain/repository/feedback_repository.dart';
import 'package:dartz/dartz.dart';

class GiveFeedback extends UseCase<int,Params>{
  FeedBackRepo feedBackRepo;
  GiveFeedback(this.feedBackRepo);
  @override
  Future<Either<Errors, int>> call(Params param) async{
    return await feedBackRepo.giveFeedback(param.feedbackMessage, param.feedbackCategory, param.rating);
  }

}

class Params {
  String feedbackMessage;
  List<String> feedbackCategory;
  double rating;
  Params({required this.feedbackMessage, required this.feedbackCategory, required this.rating});
}