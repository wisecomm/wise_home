import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'user_info.dart';
import 'wflib/wfapp_state.dart';
import 'wflib/wfmenu_route.dart';

void main() {
  Intl.defaultLocale = 'ko';

  var userInfo = UserInfo();
  var wfappState = WFAppState(userInfo);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: wfappState),

        /// ROOT CONTEXT, Allows Commands to retrieve a 'safe' context that is not tied to any one view. Allows them to work on async tasks without issues.
        Provider<BuildContext>(create: (c) => c),
      ],
      child: const MainApp(),
    ),
  );
}

/// MainApp
/// * Binds to AppModel.theme, and injects current AppTheme to the rest of the App
/// * Runs the BootStrapperCommand
/// * Wraps a MaterialApp, assigning it a navKey so the Commands can access the root level navigator
class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final bool _settingsLoaded = false;

  @override
  void initState() {
    super.initState();
/*
    context.read<WFAppState>().load().then((value) async {
      print("_settingsLoaded = " + _settingsLoaded.toString());

      /// Rebuild now that we have our loaded settings
//      setState(() => _settingsLoaded = true);
    });
*/
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', ''), Locale('ko', '')],
      theme: ThemeData(
        textTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      // 메뉴 사용
      onGenerateRoute: (route) {
        return WFMenuRouter.getRoute(route, context);
      },
    );
  }
}
