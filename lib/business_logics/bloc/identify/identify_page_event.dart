abstract class IdentifyPageEvent {}

class ShowModelEvent extends IdentifyPageEvent {}

class CameraControllerInitFinishEvent extends IdentifyPageEvent {}

class TapGalleryButtonEvent extends IdentifyPageEvent {
  final String? apiPath;

  TapGalleryButtonEvent(this.apiPath);
}

class TapTakePictureButtonEvent extends IdentifyPageEvent {
  final String? apiPath;

  TapTakePictureButtonEvent(this.apiPath);
}
