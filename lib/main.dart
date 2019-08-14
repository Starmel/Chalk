import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker/app/deeplink/deeeplink_observer.dart';
import 'package:time_tracker/app/di.dart';
import 'package:time_tracker/app/ui/app_colors.dart';
import 'package:time_tracker/app/ui/scene/splash/splash_scene.dart';
import 'package:time_tracker/redux/router_middleware.dart';

void main() async {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;

  await DI.init();

  DeeplinkObserver.start();

  runApp(TimeTrackerApp());
}

class TimeTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: "Chalk",
        debugShowCheckedModeBanner: false,
        navigatorKey: RouterMiddleware.appNavigatorKey,
        theme: ThemeData(
          brightness: Brightness.light,
          buttonTheme: ButtonThemeData(
            textTheme: ButtonTextTheme.primary,
            buttonColor: AppColors.accent,
          ),
          accentColor: AppColors.accent,
          primaryColor: AppColors.primary,
        ),
        home: SplashScene(),
      );
}
