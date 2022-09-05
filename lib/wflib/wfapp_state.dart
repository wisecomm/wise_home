import 'package:flutter/material.dart';

import '../user_info.dart';
import 'wfshared_pref_json.dart';

class WFAppState extends ChangeNotifier {
  WFAppState(this._userInfo);

  static const String CON_FILE_NAME = "app.settings";

  // 사용자 정보 저장
  final UserInfo _userInfo;
  // 로그인 성공여부
  bool bLoginSucess = false;

  UserInfo getUserInfo() {
    return _userInfo;
  }

  //Loads a string from disk, and parses it into ourselves.
  Future<void> load() async {
    return WFSharedPrefJson.read(CON_FILE_NAME).then((result) {
      UserInfo oUserInfo = UserInfo.fromJson(result);
      _userInfo.userid = oUserInfo.userid;
      _userInfo.passwd = oUserInfo.passwd;
      _userInfo.useridSaveCheck = oUserInfo.useridSaveCheck;
    });
  }

  Future<void> save() async {
    WFSharedPrefJson.save(CON_FILE_NAME, _userInfo.toJson());
  }

// This call tells the widgets that are listening to this model to rebuild.
//    notifyListeners();

  // 화면 데이터 저장
  final _appData = {};

  dynamic getAppData(String key) {
    return _appData[key];
  }

  void setAppData(String key, dynamic value) {
    _appData[key] = value;
  }
}

/*
# 참조 사이트 
# https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple

*/
