
import 'package:equatable/equatable.dart';
import 'package:begara_mobile/feauters/house/domain/entity/image_entity.dart';

class ImageModel extends Equatable{
  final int imageId;
  final String imageUrl;

  const ImageModel({required this.imageId, required this.imageUrl});

  @override
  List<Object?> get props => [imageId, imageUrl];

  Map<String, dynamic> toJson(){
    return{
      "imageId":imageId,
      "imageUrl":imageUrl
    };
  }

  factory ImageModel.fromJson(Map<String,dynamic> json){
    return ImageModel(imageId: json["imageId"], imageUrl: json["imageUrl"]);
  }


  ImageEntity toEntity(){
    return ImageEntity(imageId:imageId , imageUrl: imageUrl);
  }

}
