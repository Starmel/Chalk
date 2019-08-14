import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker/redux/redux.dart';

class RouterMiddleware<T> extends Middleware<T> {
  NavigatorState get navigator => appNavigatorKey.currentState;

  BuildContext get context => appNavigatorKey.currentContext;

  static final appNavigatorKey = GlobalKey<NavigatorState>();
}
