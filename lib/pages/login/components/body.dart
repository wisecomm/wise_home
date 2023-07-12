import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../components/already_have_an_acount_check.dart';
import '../..//components/rounded_button.dart';
import '../..//components/rounded_input_field.dart';
import '../..//components/rounded_password_field.dart';
import '../..//login/components/back_ground.dart';
import '../../signup/signup_page.dart';
import '../../../wflib/wfapp_state.dart';
import '../../../wflib/wfutils/wfhttp_util.dart';

import '../../../user_info.dart';
import '../mock_login.dart';

import 'package:js/js.dart';
import './web_script_int.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';

@JS('wPluginCallback')
external set _wPluginCallback(Function(dynamic payload) f);
@JS()
external dynamic wPluginCallback();

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _MyState();
}

class _MyState extends State<Body> {
  final TextEditingController _usernameController = TextEditingController();
  bool _useridSaveCheck = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => _formInit(context));

    debugPrint("_onBootpayDone end");
  }

  // 폼 초기화
  _formInit(BuildContext context) async {
    debugPrint("_formInit start");
    final WFAppState oWFAppState =
        Provider.of<WFAppState>(context, listen: false);

    final UserInfo userInfo = oWFAppState.getUserInfo();
    _useridSaveCheck = userInfo.useridSaveCheck;
    debugPrint("사용자 정보 저장= $_useridSaveCheck.toString()");

    setState(() {
      _usernameController.text = userInfo.userid;
      _useridSaveCheck = userInfo.useridSaveCheck;
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("build start");
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Login',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              'assets/icons/login.svg',
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: 'Your Email',
              onChanged: (value) {},
              icon: Icons.person,
              controller: _usernameController,
            ),
            RoundedPasswordField(
              onChanged: (value) {},
            ),
            RoundedButton(
              text: '로그인',
              onPressed: () {
                _btnLogin(context);
              },
            ),
            SizedBox(
              width: size.width * 0.8,
              child: CheckboxListTile(
                  title: const Text("아이디 저장"), //    <-- label
                  value: _useridSaveCheck,
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (newValue) {
                    if (newValue != null) {
                      setState(() {
                        _useridSaveCheck = newValue;
                      });
                    }
                  }),
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAcountCheck(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const SignUpPage();
                  }),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _btnLogin(BuildContext context) async {
    // 요청 데이터 샛팅
    final loginInput = LoginInput("eve.holt@reqres.in", "cityslicka");

    _wPluginCallback = allowInterop((data) {
      // debugPrint("_wPluginCallback data1111");
      // final rawJson = '{"name":"Mary","age":30}';
      // final map = jsonDecode(rawJson) as Map<String, dynamic>;
      // debugPrint("_wPluginCallback data2222 nmae=" + map['name']);

      debugPrint("_wPluginCallback 111133");
      debugPrint("_wPluginCallback data22kk21=$data.toString()");
      debugPrint("_wPluginCallback data22kk22=$data[0]");

      final map3 = data as Map<dynamic, dynamic>;
      debugPrint("_wPluginCallback data22kk3=" + map3.toString());
/*
      debugPrint("_wPluginCallback 1111kk");
      debugPrint("_wPluginCallback 2222pp");
      List<dynamic> lists = data as List<dynamic>;
      debugPrint("_wPluginCallback 111122pp===11");
      debugPrint("_wPluginCallback 1111221===" + lists.toString());
*/
      /*
      debugPrint(
          "_wPluginCallback 1111221===" + lists[0].runtimeType.toString());

//      debugPrint(
      //         "_wPluginCallback 111122 runtype=" + data.runtimeType.toString());

      debugPrint("_wPluginCallback 111122" + lists.first.toString());
*/
/*      
      debugPrint("_wPluginCallback data223=" + data[1].toString());

      try {
        Map<String, dynamic> jsonData = jsonDecode(data[0]);
      } catch (e) {
        print("ERROR1====");
        var message = e.toString();
        print("ERROR2=" + message);
      }
*/
/*
      var params = jsonData['result'];
      var returnCode = params.get('returnCode');

      if ("0" == returnCode.toString()) {
        // 초기 화면 이동 (모든 이전 화면 제거)
        Navigator.of(context).pushNamedAndRemoveUntil(
            '/tabbar', (Route<dynamic> route) => false);
      } else {
        var returnMsg = params.get('returnMsg');
        flutterShowDialog('returnCode=$returnCode returnMsg=$returnMsg');
      }
*/
    });

    await WFHttpUtil.post(LoginInput.URL,
            body: loginInput.toJson(), context: context)
        .then((response) {
      if (WFHttpUtil.checkSucess(response) == false) {
        debugPrint('http error= $response.toString()');
        return false;
      }
      final LoginOutput loginOutput = LoginOutput.fromJson(response);
      debugPrint('loginOutput.token=$loginOutput.token');

      final WFAppState oWFAppState =
          Provider.of<WFAppState>(context, listen: false);
      final UserInfo userInfo = oWFAppState.getUserInfo();

      oWFAppState.bLoginSucess = true;
      // 로그인 정보 저장
      userInfo.userid = _usernameController.text;
      userInfo.passwd = "패스워드";
      userInfo.useridSaveCheck = _useridSaveCheck;
      oWFAppState.save();

      final isWebMobile = kIsWeb &&
          (defaultTargetPlatform == TargetPlatform.iOS ||
              defaultTargetPlatform == TargetPlatform.android);
      if (isWebMobile == true) {
        checkJiMunCall();
      } else {
        // 초기 화면 이동 (모든 이전 화면 제거)
        Navigator.of(context).pushNamedAndRemoveUntil(
            '/tabbar', (Route<dynamic> route) => false);
      }
    });
  }

  void flutterShowDialog(String strContent) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("지문인증 결과"),
            content: Text(strContent),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          );
        });
  }
}
