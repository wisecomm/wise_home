import 'package:intl/intl.dart';

class WorkInfoInput {
  static const String URL = 'https://reqres.in/api/login';
  final String email;
  final String password;

  WorkInfoInput(this.email, this.password);

  WorkInfoInput.fromJson(Map<String, dynamic> json)
      : email = json["email"],
        password = json["password"];

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}

class WorkInfo {
  String _worktype;
  String _workcheck;
  String _worktime;

  WorkInfo(this._worktype, this._workcheck, this._worktime);

  factory WorkInfo.fromJson(Map<String, dynamic> json) {
    return WorkInfo(
      json["worktype"],
      json["workcheck"],
      json["worktime"],
    );
  }

  Map<String, dynamic> toJson() => {
        "worktype": _worktype,
        "workcheck": _workcheck,
        "worktime": _worktime,
      };

  @override
  String toString() => "$_worktype : $_worktime";

  set workcheck(String workcheck) {
    this._workcheck = workcheck;
    if (_workcheck == "true") {
      _worktime = DateFormat('a hh:mm').format(DateTime.now());
    } else {
      _worktime = "    --:--";
    }
  }

  get workcheckBool {
    if (this._workcheck == "true")
      return true;
    else
      return false;
  }

  get worktime {
    if (_worktime == "")
      return "    --:--";
    else
      return _worktime;
  }

  static WorkInfo getCheckList(List<WorkInfo> workInfo, int index) {
    if (workInfo.length < (index + 1))
      return WorkInfo((index + 1).toString(), "false", "");

    return workInfo[index];
  }

  static final dummyData = [
    {"worktype": "1", "workcheck": "false", "worktime": ""},
    {"worktype": "2", "workcheck": "false", "worktime": ""},
    {"worktype": "3", "workcheck": "false", "worktime": ""},
    {"worktype": "4", "workcheck": "false", "worktime": ""},
  ];
}
