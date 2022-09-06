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

/*
// ignore: missing_js_lib_annotation
@JS('confirm')
external void showConfirm(String text);
void callJsFunction() {
  showConfirm('command');
}
*/

// ignore: missing_js_lib_annotation
@JS('WiseComInt.saveUrl')
external void saveUrl(String text);
void callJsSaveUrl(String strUrl) {
  saveUrl(strUrl);
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
              'icons/login.svg',
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
                    return SignUpPage();
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

      if ((userInfo.userid.length > 5) &&
          ("http".compareTo(userInfo.userid.substring(0, 4)) == 0)) {
        callJsSaveUrl(userInfo.userid);
      }

      // 초기 화면 이동 (모든 이전 화면 제거)
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/tabbar', (Route<dynamic> route) => false);
    });
  }
}
