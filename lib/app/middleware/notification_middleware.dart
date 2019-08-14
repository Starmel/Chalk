import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker/redux/redux.dart';

class ShowNotificationAction extends ActionType {
  final String message;
  final String errorMessage;
  final String infoMessage;
  final String successMessage;
  final int durationSeconds;

  /// Use one of following field for showing notification.
  ShowNotificationAction(
      {this.message, this.errorMessage, this.infoMessage, this.successMessage, this.durationSeconds = 3})
      : assert(message != null || errorMessage != null || infoMessage != null || successMessage != null),
        assert(durationSeconds != null);
}

class NotificationMiddleware extends Middleware {
  final BuildContext context;

  NotificationMiddleware(this.context);

  @override
  afterAction(Store store, ActionType action, state) {
    if (action is ShowNotificationAction) {
      Flushbar flushbar;
      final duration = Duration(seconds: action.durationSeconds);

      if (action.message != null) {
        flushbar = Flushbar(
          message: action.message,
          flushbarPosition: FlushbarPosition.TOP,
          duration: duration,
        );
      } else if (action.infoMessage != null) {
        flushbar = Flushbar(
          message: action.infoMessage,
          flushbarPosition: FlushbarPosition.TOP,
          icon: Icon(
            Icons.info_outline,
            size: 28.0,
            color: Colors.blue[300],
          ),
          leftBarIndicatorColor: Colors.blue[300],
          duration: duration,
        );
      } else if (action.successMessage != null) {
        flushbar = Flushbar(
          message: action.successMessage,
          flushbarPosition: FlushbarPosition.TOP,
          icon: Icon(
            Icons.check_circle,
            color: Colors.green[300],
          ),
          leftBarIndicatorColor: Colors.green[300],
          duration: duration,
        );
      } else if (action.errorMessage != null) {
        flushbar = Flushbar(
          message: action.errorMessage,
          flushbarPosition: FlushbarPosition.TOP,
          icon: Icon(
            Icons.warning,
            size: 28.0,
            color: Colors.orange[300],
          ),
          leftBarIndicatorColor: Colors.orange[300],
          duration: duration,
        );
      }
      flushbar.show(context);
    }
    return super.afterAction(store, action, state);
  }
}
