import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/controllers/app_constant.dart';
import 'package:reviews_link_v2/initial_binding.dart';
import 'package:reviews_link_v2/l10n/app_localizations.dart';
import 'package:reviews_link_v2/res/Keys.dart';
import 'package:reviews_link_v2/res/app_theme.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(400, 900),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          navigatorKey: Keys.navigatorKey,
          initialBinding: InitialBinding(),
          title: AppConstant.applicationName,
          defaultTransition: Transition.cupertino,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            primaryColor: primaryColor,
            textTheme: AppTheme.textTheme,
            appBarTheme: AppTheme.appBarTheme,
          ),
          themeMode: ThemeMode.light,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: Locale('en'),
          getPages: AppRouting.routes(),
          initialRoute: '/',
        );
      },
    );
  }
}
