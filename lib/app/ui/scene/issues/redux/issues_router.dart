import 'package:flutter/material.dart';
import 'package:time_tracker/app/ui/scene/issues/redux/issues_action.dart';
import 'package:time_tracker/app/ui/scene/issues/redux/issues_state.dart';
import 'package:time_tracker/app/ui/scene/login/login_scene.dart';
import 'package:time_tracker/app/ui/scene/tracker/tracker_scene.dart';
import 'package:time_tracker/app/ui/view/transparent_router.dart';
import 'package:time_tracker/redux/redux.dart';
import 'package:time_tracker/redux/router_middleware.dart';

class IssuesRouterMiddleWare extends RouterMiddleware<IssuesState> {
  @override
  IssuesState afterAction(Store<IssuesState> store, ActionType action, IssuesState state) {
    if (action is DoLogoutAction) {
      navigator.pushReplacement(MaterialPageRoute(builder: (_) => LoginScene()));
    }

    if (action is OpenTrackerSceneAction) {
      if (action.availableActivities != null && action.availableActivities.isNotEmpty) {
        navigator.push(TransparentRoute(
          builder: (_) => TrackerScene(action.issueModel, action.availableActivities),
        ));
      } else {
        // TODO: Show Error Alert
        print("IssuesRouterMiddleWare.afterAction: activities is not loaded.");
      }
    }

    return super.afterAction(store, action, state);
  }
}
