import 'package:begara_mobile/core/error/errors.dart';
import 'package:dartz/dartz.dart';

abstract class FeedBackRepo{
  Future<Either<Errors,int>> giveFeedback(String feedbackMessage, List<String> feedbackCategory, double rating);
}