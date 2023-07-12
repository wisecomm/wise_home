import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../wflib/WebAppInterface.dart';
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

@JS('jsBootpay')
external dynamic requestBootpayWeb(String payload);

@JS('onBootpayDone')
external set _onBootpayDone(Function(dynamic payload) f);

@JS()
external dynamic onBootpayDone();

/*
// ignore: missing_js_lib_annotation
@JS('confirm')
external void showConfirm(String text);
void callJsFunction() {
  showConfirm('command');
}
*/

// ignore: missing_js_lib_annotation
//@JS('WiseComInt.saveUrl')
@JS('WebAppInterface.getGalleryPhoto')
external void getGalleryPhoto();
void callJsSaveUrl(String strUrl) {
  getGalleryPhoto();
}

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

    debugPrint("_onBootpayDone start");
    _onBootpayDone = allowInterop((data) {
      debugPrint("ggg");
    });
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

      String strReturn = checkJiMunCall();

      Map<String, dynamic> jsonData = jsonDecode(strReturn);
      flutterShowDialog("jsonData=");
/*
      if ("0" == jsonData['returnCode']) {
        // 초기 화면 이동 (모든 이전 화면 제거)
        Navigator.of(context).pushNamedAndRemoveUntil(
            '/tabbar', (Route<dynamic> route) => false);
      } else {
        flutterShowDialog(jsonData['returnMsg']);
      }
*/
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
