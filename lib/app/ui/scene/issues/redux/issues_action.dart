import 'package:time_tracker/app/di.dart';
import 'package:time_tracker/app/middleware/notification_middleware.dart';
import 'package:time_tracker/app/ui/scene/issues/redux/issues_state.dart';
import 'package:time_tracker/domain/gateway/redmine_gateway.dart';
import 'package:time_tracker/domain/gateway/settings_gateway.dart';
import 'package:time_tracker/domain/gateway/time_cache_gateway.dart';
import 'package:time_tracker/domain/model/activity_model.dart';
import 'package:time_tracker/domain/model/issue_model.dart';
import 'package:time_tracker/redux/redux.dart';

class DoLoadRedmineInfoAction extends ActionType {}

class DoLoadIssuesAction extends AsyncAction<IssuesState> {
  @override
  Future<Computation<IssuesState>> reduce(IssuesState state) async {
    final redmineGateway = injector.get<RedmineGateway>();

    try {
      final lastIssues = await redmineGateway.getLastIssues();

      return (IssuesState actualState) => actualState.rebuild(
            (u) => u
              ..issues = lastIssues
              ..loadingErrorMessage = null
              ..isLoading = false,
          );
    } catch (e) {
      return (IssuesState actualState) => actualState.rebuild(
            (u) => u
              ..isLoading = false
              ..loadingErrorMessage = "Issues fetch error.",
          );
    }
  }

  @override
  IssuesState reduceSync(IssuesState state) {
    return state.rebuild(
      (b) => b..isLoading = true,
    );
  }
}

class DoLoadActivitiesAction extends AsyncAction<IssuesState> {
  @override
  Future<Computation<IssuesState>> reduce(IssuesState state) async {
    final RedmineGateway redmineGateway = injector.get();
    final SettingsGateway settings = injector.get();

    try {
      final activities = await redmineGateway.getActivities();
      await settings.setAvailableActivities(activities);

      var availableActivities = await settings.getAvailableActivities();

      print("DoLoadActivitiesAction.reduce: availableActivities = $availableActivities");

      return (IssuesState actualState) => actualState.rebuild(
            (u) => u
              ..loadingErrorMessage = null
              ..isLoading = false,
          );
    } catch (e, s) {
      print(e);
      print(s);
      return (IssuesState actualState) => actualState.rebuild(
            (u) => u
              ..isLoading = false
              ..loadingErrorMessage = "Activities fetch error.",
          );
    }
  }

  @override
  IssuesState reduceSync(IssuesState state) {
    return state.rebuild(
      (b) => b..isLoading = true,
    );
  }
}

class DoLogoutAction extends AsyncAction<IssuesState> {
  @override
  Future<Computation<IssuesState>> reduce(IssuesState state) async {
    final TimeCacheGateway timeCacheGateway = injector.get();
    final SettingsGateway settingsGateway = injector.get();
    await settingsGateway.setApiURl(null);
    await settingsGateway.setApiToken(null);
    await settingsGateway.setLogin(null);
    await settingsGateway.setPassword(null);
    await timeCacheGateway.removeAll();

    return (IssuesState actualState) => actualState;
  }
}

class OpenTrackerSceneAction extends AsyncAction<IssuesState> {
  final IssueModel issueModel;
  List<ActivityModel> availableActivities;

  OpenTrackerSceneAction(this.issueModel);

  @override
  Future<Computation<IssuesState>> reduce(IssuesState state) async {
    final SettingsGateway settingsGateway = injector.get();
    availableActivities = await settingsGateway.getAvailableActivities();
    return (IssuesState actualState) => actualState;
  }
}

class DoSearchIssueAction extends AsyncAction<IssuesState> {
  final String text;

  DoSearchIssueAction(this.text);

  @override
  Future<Computation<IssuesState>> reduce(IssuesState state) async {
    final RedmineGateway redmineGateway = injector.get();

    try {
      final IssueModel issue = await redmineGateway.findIssueByText(text);

      store.dispatch(OpenTrackerSceneAction(issue));
    } catch (e, s) {
      print(e);
      store.dispatch(ShowNotificationAction(errorMessage: "Issue not found"));
    }
    return (IssuesState actualState) => actualState;
  }
}
