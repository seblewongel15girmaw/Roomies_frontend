import 'dart:async';

import 'package:begara_mobile/feauters/feedback/domain/usecases/give_feedback.dart';
import 'package:begara_mobile/feauters/feedback/presentation/blocs/feedback/feedback_event.dart';
import 'package:begara_mobile/feauters/feedback/presentation/blocs/feedback/feedback_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedBackBloc extends Bloc<SendFeedBackEvent, FeedBackState> {
  GiveFeedback giveFeedback;
  FeedBackBloc(this.giveFeedback) : super(Idle()) {
    on<SendFeedBackEvent>(_sendFeedback);
  }

  FutureOr<void> _sendFeedback(SendFeedBackEvent event, Emitter emit) async {
    emit(SendingFeedBack());
    Params param = Params(
        feedbackMessage: event.feedbackMessage,
        feedbackCategory: event.feedbackCategory,
        rating: event.rating);
    final response = await giveFeedback(param);
    response.fold(
        (l) => emit(FeedBackFailed()), (r) => emit(FeedBackSuccess()));
  }
}
