import 'package:begara_mobile/core/error/errors.dart';
import 'package:begara_mobile/core/error/exceptions.dart';
import 'package:begara_mobile/core/platform/network_info.dart';
import 'package:begara_mobile/feauters/auth/data/data_source/guarantor_data_sources.dart';
import 'package:begara_mobile/feauters/auth/domain/repository/guarantorRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

class GuarantorRepoImpl implements GuarantorRepo{
  final GuarantorDataSource guarantorDataSource;
  final Network network;
  GuarantorRepoImpl(this.guarantorDataSource,this.network);
  @override
  Future<Either<Errors, int>> createGuarantor(String fullName, String phoneNumber, String gender, String image, Map address, XFile idImage) async{
    try{
      network.isConnected;
      return Right(await guarantorDataSource.createGuarantor(fullName, phoneNumber, gender, image, idImage, address));
    }
    on ServerExceptions{
      return Left(ServerErrors());
    }
  }
}