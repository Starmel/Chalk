import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/app/event_bus.dart';
import 'package:time_tracker/app/middleware/notification_middleware.dart';
import 'package:time_tracker/app/ui/app_colors.dart';
import 'package:time_tracker/app/ui/scene/issues/redux/issues_action.dart';
import 'package:time_tracker/app/ui/scene/issues/redux/issues_redmine_middleware.dart';
import 'package:time_tracker/app/ui/scene/issues/redux/issues_router.dart';
import 'package:time_tracker/app/ui/scene/issues/redux/issues_state.dart';
import 'package:time_tracker/app/ui/scene/issues/view/issues_view.dart';
import 'package:time_tracker/redux/redux.dart';

class IssuesScene extends StatefulWidget {
  static const navigationKey = "IssuesScene";

  @override
  IssuesSceneState createState() {
    return IssuesSceneState();
  }
}

class IssuesSceneState extends State<IssuesScene> {
  Store<IssuesState> store;
  StreamSubscription eventBusStream;

  @override
  void initState() {
    store = Store<IssuesState>(
      initialState: IssuesState.initial(),
      middlewares: [
        IssuesRouterMiddleWare(),
        IssuesRedmineMiddleWare(),
        NotificationMiddleware(context),
      ],
    );

    eventBusStream = eventBus.on().listen((event) {
      /// To prevent firing screen action if other is open.
      if (ModalRoute.of(context).isCurrent) {
        if (event is ActionType) {
          store.dispatch(event);
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backBackground,
      appBar: AppBar(
        title: Text("Chalk"),
        actions: <Widget>[
          buildLogoutButton(),
        ],
        leading: Image.asset("resources/drawable/chalk-logo-wobg.png"),
      ),
      body: ChangeNotifierProvider(
        builder: (_) => store,
        child: IssuesView(),
      ),
    );
  }

  Widget buildLogoutButton() {
    return Material(
      color: AppColors.accent,
      child: InkWell(
        splashColor: Colors.white,
        onTap: () {
          store.dispatch(DoLogoutAction());
        },
        child: Container(
          width: 100,
          child: Center(child: Text("Disconnect")),
        ),
      ),
    );
  }

  @override
  void dispose() {
    eventBusStream.cancel();
    super.dispose();
  }
}
