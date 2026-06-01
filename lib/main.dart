import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/controllers/app_constant.dart';
import 'package:reviews_link_v2/initial_binding.dart';
import 'package:reviews_link_v2/l10n/app_localizations.dart';
import 'package:reviews_link_v2/res/Keys.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return GetMaterialApp(
      navigatorKey: Keys.navigatorKey,
      initialBinding: InitialBinding(),
      title: AppConstant.applicationName,
      defaultTransition: Transition.cupertino,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        useMaterial3: false,
        primaryColor: primaryColor,
        appBarTheme: AppBarTheme(color: primaryColor),
      ),
      themeMode: ThemeMode.light,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale('en'),
      getPages: AppRouting.routes(),
      initialRoute: '/',
    );
  }
}
