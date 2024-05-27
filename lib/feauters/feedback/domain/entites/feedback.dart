import 'package:equatable/equatable.dart';

class FeedBack extends Equatable {
  final String feedbackMessage;
  final List<String> feedbackCategory;
  final double rating;
  FeedBack(
      {required this.feedbackMessage,
      required this.feedbackCategory,
      required this.rating});

  @override
  // TODO: implement props
  List<Object?> get props => [feedbackMessage, feedbackCategory, rating];

  Map<String, dynamic> toJson() {
    return {
      "feedback_message": feedbackMessage,
      "feedback_category": feedbackCategory,
      "rating": rating
    };
  }
}
