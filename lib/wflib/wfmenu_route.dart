import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../pages/login/login_page.dart';
import '../pages/welcome/welcome_page.dart';
import '../tabbar/tabbar_bottom.dart';
import '../wflib/wfapp_state.dart';

import '../user_info.dart';

class WFMenuRouter {
/*
Route getRoute(RouteSettings settings, BuildContext context) {

  switch (settings.name) {
    case '/':
      return _rootNodeCheck(settings, context);
    case '/login':
      return _buildRoute(settings, LoginPage());
    case '/register_user':
      return _buildRoute(settings, RegisterUser());
    case '/sms':
      return _buildRoute(settings, BubbleScreen());
    default: 
      return null;
  }
}

// 메인 페이지 결정(로그인, 메인)
MaterialPageRoute _rootNodeCheck(RouteSettings settings, BuildContext context){
  final UserInfo userInfo = Provider.of<WAppState>(context).getUserInfo();

  if(userInfo == null)
    return _buildRoute(settings, SplashScreen());


  if((userInfo.isLoginSuccess == false) ) {
    return _buildRoute(settings, LoginPage());
  } else {
    return _buildRoute(settings, MainTabsPage());
  }
}
*/
  static Route getRoute(RouteSettings settings, BuildContext context) {
/*
    final WFAppState wfAppState =
        Provider.of<WFAppState>(context, listen: false);
    if (wfAppState.bLoginSucess == false) {
      return _buildRoute(settings, LoginPage());
    }
*/
    switch (settings.name) {
      case '/':
//        return _buildRoute(settings, TabbarBottom());
        return _buildRoute(settings, LoginPage());
      case '/tabbar':
        return _buildRoute(settings, TabbarBottom());
      case '/initial':
        return _buildRoute(settings, WelcomePage());
      default:
        return _buildRoute(settings, WelcomePage());
    }
  }

  static MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return MaterialPageRoute(
      settings: settings,
      builder: (BuildContext context) => builder,
    );
  }
}
