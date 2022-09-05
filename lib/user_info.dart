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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userid'] = this.userid;
    data['passwd'] = this.passwd;
    data['useridsavecheck'] = this.useridSaveCheck;
    data['autologincheck'] = this.autoLoginCheck;
    return data;
  }
}
