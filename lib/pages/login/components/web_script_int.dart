import 'package:js/js.dart';

@JS('WebAppInterface.getGalleryPhoto')
external void getGalleryPhoto();
void getGalleryPhotoCall() {
  getGalleryPhoto();
}

@JS('WebAppInterface.checkJiMun')
external String checkJiMun();
String checkJiMunCall() {
  return checkJiMun();
}
