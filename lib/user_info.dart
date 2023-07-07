class UserInfo {
  String userid = "";
  String passwd = "";
  bool useridSaveCheck = false;
  bool autoLoginCheck = false;

//  bool isLoginSuccess = false;
  UserInfo();

  UserInfo.fromJson(Map<String, dynamic> json)
      : userid = json['userid'] ?? "",
        passwd = json['passwd'] ?? "",
        useridSaveCheck = json['autologincheck'] ?? false,
        autoLoginCheck = json['autologincheck'] ?? false;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userid'] = userid;
    data['passwd'] = passwd;
    data['useridsavecheck'] = useridSaveCheck;
    data['autologincheck'] = autoLoginCheck;
    return data;
  }
}
