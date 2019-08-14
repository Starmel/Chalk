import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker/app/di.dart';
import 'package:time_tracker/app/ui/scene/issues/issues_scene.dart';
import 'package:time_tracker/app/ui/scene/login/login_scene.dart';
import 'package:time_tracker/domain/gateway/settings_gateway.dart';

class SplashScene extends StatefulWidget {
  @override
  _SplashSceneState createState() => _SplashSceneState();
}

class _SplashSceneState extends State<SplashScene> {
  Future openInitialScene() async {
    final SettingsGateway settingsGateway = injector.get();

    var apiUrl = await settingsGateway.getApiUrl();
    print("TimeTrackerApp.buildInitialScene: settingsGateway.getApiUrl() = $apiUrl");

    Navigator.of(context).pushReplacement(PageRouteBuilder(
      pageBuilder: (_, __, ___) => apiUrl != null ? IssuesScene() : LoginScene(),
    ));
  }

  @override
  void initState() {
    openInitialScene();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
    );
  }
}
