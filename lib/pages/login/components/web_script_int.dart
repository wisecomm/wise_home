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

// 자바스크립트에서 호출하는 함수
@JS('onBootpayDone')
external set _onBootpayDone(Function(dynamic payload) f);
// 실제 외부에서 호출하는 함수
@JS()
external dynamic onBootpayDone();
