import 'package:begara_mobile/core/error/errors.dart';
import 'package:begara_mobile/core/error/exceptions.dart';
import 'package:begara_mobile/core/platform/network_info.dart';
import 'package:begara_mobile/feauters/feedback/data/data_source/feedback_data_source.dart';
import 'package:begara_mobile/feauters/feedback/domain/repository/feedback_repository.dart';
import 'package:dartz/dartz.dart';

class FeedBackRepoImpl implements FeedBackRepo{
  final FeedbackDataSource feedbackDataSource;
  final Network network;
  FeedBackRepoImpl(this.feedbackDataSource, this.network);
  @override
  Future<Either<Errors, int>> giveFeedback(String feedbackMessage, List<String> feedbackCategory, double rating) async{
    try{
      network.isConnected;
      return Right(await feedbackDataSource.giveFeedback(feedbackMessage, feedbackCategory, rating));
    }
    on ServerExceptions{
      return Left(ServerErrors());
    }
  }

}