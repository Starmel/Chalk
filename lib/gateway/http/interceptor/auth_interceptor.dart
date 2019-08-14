import 'package:http_interceptor/interceptor_contract.dart';
import 'package:http_interceptor/models/request_data.dart';
import 'package:http_interceptor/models/response_data.dart';
import 'package:time_tracker/domain/gateway/settings_gateway.dart';
import 'package:time_tracker/domain/util/UrlUtil.dart';

class AuthInterceptor implements InterceptorContract {
  final SettingsGateway _settingsGateway;

  AuthInterceptor(this._settingsGateway);

  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    if (!UrlUtil.hasBasicAuth(data.url)) {
      final login = await _settingsGateway.getLogin();
      final password = await _settingsGateway.getPassword();

      data.url = UrlUtil.addBasicAuth(data.url, login, password);
    }
    return Future.value(data);
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) => Future.value(data);
}
