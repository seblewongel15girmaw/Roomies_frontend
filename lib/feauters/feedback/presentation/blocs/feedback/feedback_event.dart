class SendFeedBackEvent{
  String feedbackMessage;
  List<String> feedbackCategory;
  double rating;
  SendFeedBackEvent({required this.feedbackMessage, required this.feedbackCategory, required this.rating});
}