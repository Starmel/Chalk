import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_tracker/domain/gateway/settings_gateway.dart';
import 'package:time_tracker/domain/model/activity_model.dart';

enum _Key { apiToken, apiUrl, activities, login, password }

class MMKVSettingsGateway implements SettingsGateway {
  final SharedPreferences prefs;

  MMKVSettingsGateway(this.prefs);

  @override
  Future<String> getApiToken() async => prefs.getString(_Key.apiToken.toString());

  @override
  Future<String> getApiUrl() async => prefs.getString(_Key.apiUrl.toString());

  @override
  Future<void> setApiToken(String apiToken) async {
    await prefs.setString(_Key.apiToken.toString(), apiToken);
  }

  @override
  Future<void> setApiURl(String apiUrl) async {
    await prefs.setString(_Key.apiUrl.toString(), apiUrl);
  }

  @override
  Future<List<ActivityModel>> getAvailableActivities() async {
    final savedString = await prefs.getString(_Key.activities.toString());

    if (savedString != null) {
      final List<dynamic> jsonList = json.decode(savedString);
      return jsonList.map((s) => ActivityModel.fromJson(s)).toList();
    } else {
      return null;
    }
  }

  @override
  Future<void> setAvailableActivities(List<ActivityModel> activities) async {
    await prefs.setString(_Key.activities.toString(), json.encode(activities));
  }

  @override
  Future<String> getLogin() async {
    return prefs.getString(_Key.login.toString());
  }

  @override
  Future<String> getPassword() async {
    return prefs.getString(_Key.password.toString());
  }

  @override
  Future<void> setLogin(String login) async {
    await prefs.setString(_Key.login.toString(), login);
  }

  @override
  Future<void> setPassword(String password) async {
    await prefs.setString(_Key.password.toString(), password);
  }
}
