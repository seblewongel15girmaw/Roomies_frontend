import 'dart:io';

import 'package:image_picker/image_picker.dart';

abstract class ImageState{}

class Idle extends ImageState{}

class ImageSelected extends ImageState{
  XFile? image;
  ImageSelected(this.image);
}
class IdSelected extends ImageState{
  XFile? image2;
  IdSelected(this.image2);
}