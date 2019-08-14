import 'package:meta/meta.dart';
import 'package:time_tracker/app/di.dart';
import 'package:time_tracker/app/ui/scene/login/redux/login_state.dart';
import 'package:time_tracker/domain/gateway/redmine_gateway.dart';
import 'package:time_tracker/domain/gateway/settings_gateway.dart';
import 'package:time_tracker/redux/redux.dart';

class DoLoginAction extends AsyncAction<LoginState> {
  final String apiURL;
  final String login;
  final String password;

  DoLoginAction({
    @required this.apiURL,
    @required this.login,
    @required this.password,
  });

  @override
  Future<Computation<LoginState>> reduce(LoginState state) async {
    final redmineGateway = injector.get<RedmineGateway>();
    final settingsGateway = injector.get<SettingsGateway>();

    try {
      await redmineGateway.checkApiKeyValid(apiURL, login, password);

      await settingsGateway.setApiURl(apiURL);
      await settingsGateway.setLogin(login);
      await settingsGateway.setPassword(password);

      store.dispatch(OpenIssuesSceneAction());

      return (LoginState actualState) => actualState.rebuild(
            (b) => b
              ..isLoading = false
              ..loginErrorMessage = null,
          );
    } catch (e) {
      return (LoginState actualState) => actualState.rebuild(
            (b) => b
              ..isLoading = false
              ..loginErrorMessage = e.toString(),
          );
    }
  }

  @override
  LoginState reduceSync(LoginState state) {
    return state.rebuild(
      (b) => b.isLoading = true,
    );
  }
}

class OpenIssuesSceneAction extends Action<LoginState> {
  @override
  LoginState reduce(LoginState state) => state;
}
