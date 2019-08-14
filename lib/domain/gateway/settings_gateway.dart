import 'package:time_tracker/domain/model/activity_model.dart';

abstract class SettingsGateway implements AuthSettings {
  /// Api URL
  Future<void> setApiURl(String apiUrl);

  Future<String> getApiUrl();

  /// Api Token
  Future<void> setApiToken(String apiToken);

  Future<String> getApiToken();

  /// Activities
  Future<void> setAvailableActivities(List<ActivityModel> activities);

  Future<List<ActivityModel>> getAvailableActivities();
}

abstract class AuthSettings {
  /// Login
  Future<void> setLogin(String login);

  Future<String> getLogin();

  /// Password
  Future<void> setPassword(String password);

  Future<String> getPassword();
}
