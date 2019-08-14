import 'package:flutter/material.dart';
import 'package:time_tracker/app/ui/scene/issues/issues_scene.dart';
import 'package:time_tracker/app/ui/scene/login/redux/login_actions.dart';
import 'package:time_tracker/app/ui/scene/login/redux/login_state.dart';
import 'package:time_tracker/redux/redux.dart';
import 'package:time_tracker/redux/router_middleware.dart';

class LoginRouterMiddleWare extends RouterMiddleware<LoginState> {
  @override
  LoginState afterAction(Store<LoginState> store, ActionType action, LoginState state) {
    if (action is OpenIssuesSceneAction) {
      navigator.pushReplacement(MaterialPageRoute(builder: (_) => IssuesScene()));
    }

    return super.afterAction(store, action, state);
  }
}
