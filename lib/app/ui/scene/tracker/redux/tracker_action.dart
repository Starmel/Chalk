import 'package:time_tracker/app/di.dart';
import 'package:time_tracker/app/middleware/notification_middleware.dart';
import 'package:time_tracker/app/ui/scene/tracker/redux/tracker_state.dart';
import 'package:time_tracker/domain/gateway/redmine_gateway.dart';
import 'package:time_tracker/domain/gateway/settings_gateway.dart';
import 'package:time_tracker/domain/model/activity_model.dart';
import 'package:time_tracker/domain/model/issue_model.dart';
import 'package:time_tracker/domain/use_case/push_time_use_case.dart';
import 'package:time_tracker/redux/redux.dart';
import 'package:url_launcher/url_launcher.dart';

class DoCloseTrackerScene extends ActionType {}

class DoSaveTimeAction extends AsyncAction<TrackerState> {
  final int countedSeconds;

  DoSaveTimeAction(this.countedSeconds);

  @override
  Future<Computation<TrackerState>> reduce(TrackerState state) async {
    final PushTimeUseCase pushTimeUseCase = injector.get();

    var minutes = countedSeconds ~/ 60;
    if (minutes >= 1) {
      try {
        await pushTimeUseCase.push(state.selectedIssue.id, state.selectedActivity.id, minutes);

        store.dispatch(ShowNotificationAction(successMessage: "Time saved"));
      } catch (e) {
        store.dispatch(ShowNotificationAction(
          errorMessage: "Can't save. Time will be saved later",
          durationSeconds: 5,
        ));
      }
    }

    return (TrackerState actualState) => actualState;
  }

  @override
  TrackerState reduceSync(TrackerState state) => state.rebuild(
        (b) => b..elapsedTime = state.elapsedTime + countedSeconds,
      );
}

class DoStartOrPauseTimerAction extends Action<TrackerState> {
  @override
  TrackerState reduce(TrackerState state) => state.rebuild(
        (b) => b..isRunning = !state.isRunning,
      );
}

class DoSelectTrackerAction extends Action<TrackerState> {
  final ActivityModel _activity;

  DoSelectTrackerAction(this._activity);

  @override
  TrackerState reduce(TrackerState state) => state.rebuild(
        (b) => b..selectedActivity = _activity,
      );
}

class OpenIssueInBrowserAction extends AsyncAction<TrackerState> {
  final IssueModel _issueModel;

  OpenIssueInBrowserAction(this._issueModel);

  @override
  Future<Computation<TrackerState>> reduce(TrackerState state) async {
    final SettingsGateway settingsGateway = injector.get();

    final apiUrl = await settingsGateway.getApiUrl();

    await launch("$apiUrl/issues/${_issueModel.id}");

    return (TrackerState actualState) => actualState;
  }
}

class SetCommentAction extends Action<TrackerState> {
  final String _comment;

  SetCommentAction(this._comment);

  @override
  TrackerState reduce(TrackerState state) => state.rebuild(
        (u) => u..comment = _comment,
      );
}

class AddIssueCommentAction extends AsyncAction<TrackerState> {
  final int _issueId;
  final String _comment;

  AddIssueCommentAction(this._issueId, this._comment);

  @override
  Future<Computation<TrackerState>> reduce(TrackerState state) async {
    final RedmineGateway redmineGateway = injector.get();

    try {
      await redmineGateway.addComment(_issueId, _comment);

      store.dispatch(ShowNotificationAction(successMessage: "Comment saved"));

      return (TrackerState actualState) => actualState.rebuild(
            (u) => u
              ..isCommentSending = false
              ..comment = "",
          );
    } catch (e) {
      print(e);

      store.dispatch(ShowNotificationAction(errorMessage: "Could not save comment"));

      return (TrackerState actualState) => actualState.rebuild(
            (u) => u
              ..isCommentSending = false
              ..comment = _comment,
          );
    }
  }

  @override
  TrackerState reduceSync(TrackerState state) => state.rebuild(
        (u) => u..isCommentSending = true,
      );
}
