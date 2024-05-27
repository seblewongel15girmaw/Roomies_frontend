import 'package:begara_mobile/feauters/feedback/domain/entites/feedback.dart';

class FeedbackModel extends FeedBack {
  FeedbackModel({
    required String feedbackMessage,
    required List<String> feedbackCategory,
    required double rating,
  }) : super(
            feedbackCategory: feedbackCategory,
            feedbackMessage: feedbackMessage,
            rating: rating);
  factory FeedbackModel.fromJson(Map<String, dynamic> map) {
    return FeedbackModel(
        feedbackMessage: map["feedback_message"],
        feedbackCategory: map["feedback_category"],
        rating: map["rating"]);
  }
}
