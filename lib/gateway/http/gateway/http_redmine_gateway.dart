import 'dart:convert';

import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:time_tracker/domain/gateway/redmine_gateway.dart';
import 'package:time_tracker/domain/gateway/settings_gateway.dart';
import 'package:time_tracker/domain/model/activity_model.dart';
import 'package:time_tracker/domain/model/issue_model.dart';
import 'package:time_tracker/domain/util/UrlUtil.dart';
import 'package:time_tracker/gateway/http/Entity/http_entities.dart';

class HttpRedmineGateway implements RedmineGateway {
  final Client client;
  final SettingsGateway _settingsGateway;

  const HttpRedmineGateway(
    this._settingsGateway, {
    @required this.client,
  });

  @override
  Future<void> checkApiKeyValid(String url, String login, String password) async {
    final urlWithAuth = UrlUtil.addBasicAuth(url, login, password);
    final response = await client.get("$urlWithAuth/projects.json?");
    if (response.statusCode != 200) {
      throw Exception("Bad response code");
    }
  }

  @override
  Future<List<IssueModel>> getLastIssues() async {
    final url = await _settingsGateway.getApiUrl();
    final response = await client.get("$url/issues.json?assigned_to_id=me");

    final jsonResponse = json.decode(response.body);
    final issuesJson = jsonResponse["issues"] as List;

    return issuesJson.map((i) => IssueModel.fromJson(i)).toList();
  }

  @override
  Future<List<ActivityModel>> getActivities() async {
    final url = await _settingsGateway.getApiUrl();
    final response = await client.get("$url/enumerations/time_entry_activities.json");

    final jsonResponse = json.decode(response.body);
    var issuesJson = jsonResponse["time_entry_activities"] as List;

    return issuesJson.map((i) => ActivityModel.fromJson(i)).toList();
  }

  @override
  Future<void> saveTime(int issueId, int minutes, int activityId) async {
    final url = await _settingsGateway.getApiUrl();

    final body = createTimeEntriesBody(issueId, minutes, activityId);
    await client.post(
      "$url/time_entries.json",
      headers: {"Content-Type": "application/json"},
      body: body.toString(),
    );
  }

  @override
  Future<IssueModel> findIssueByText(String text) async {
    final issueId = int.parse(text);

    final url = await _settingsGateway.getApiUrl();
    final response = await client.get("$url/issues/$issueId.json");

    final jsonResponse = json.decode(response.body);
    final issueJson = jsonResponse["issue"];

    return IssueModel.fromJson(issueJson);
  }

  @override
  Future<void> addComment(int issueId, String comment) async {
    final url = await _settingsGateway.getApiUrl();

    final body = createIssueNoteBody(comment);

    final response = await client.put(
      "$url/issues/$issueId.json",
      headers: {"Content-Type": "application/json"},
      body: body.toString(),
    );

    if (response.statusCode != 200) {
      throw Exception("Bad response code");
    }
  }
}
