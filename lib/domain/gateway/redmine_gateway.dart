import 'package:time_tracker/domain/model/activity_model.dart';
import 'package:time_tracker/domain/model/issue_model.dart';

abstract class RedmineGateway {
  Future<void> checkApiKeyValid(String url, String login, String password);

  Future<List<IssueModel>> getLastIssues();

  Future<List<ActivityModel>> getActivities();

  Future<void> saveTime(int issueId, int minutes, int activityId);

  Future<IssueModel> findIssueByText(String text);

  Future<void> addComment(int issueId, String comment);
}
