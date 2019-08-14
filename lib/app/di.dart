import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_client_with_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_tracker/domain/gateway/redmine_gateway.dart';
import 'package:time_tracker/domain/gateway/settings_gateway.dart';
import 'package:time_tracker/domain/gateway/time_cache_gateway.dart';
import 'package:time_tracker/domain/use_case/push_time_use_case.dart';
import 'package:time_tracker/gateway/http/gateway/http_redmine_gateway.dart';
import 'package:time_tracker/gateway/http/interceptor/auth_interceptor.dart';
import 'package:time_tracker/gateway/http/interceptor/logging_interceptor.dart';
import 'package:time_tracker/gateway/mmkv/mmkv_settings_gateway.dart';
import 'package:time_tracker/gateway/mmkv/mmkv_time_cache_gateway.dart';

Injector injector;

class DI {
  static init() async {
    injector = Injector.getInjector();

    final prefs = await SharedPreferences.getInstance();

    injector.map<SettingsGateway>(
      (i) => MMKVSettingsGateway(prefs),
      isSingleton: true,
    );
    injector.map<Client>(
      (i) => HttpClientWithInterceptor.build(interceptors: [
        AuthInterceptor(
          i.get<SettingsGateway>(),
        ),
        LoggingInterceptor(),
      ]),
      isSingleton: true,
    );
    injector.map<RedmineGateway>(
      (i) => HttpRedmineGateway(
        i.get<SettingsGateway>(),
        client: i.get<Client>(),
      ),
    );
    injector.map<TimeCacheGateway>(
      (i) => MMkvTimeCacheGateway(prefs),
    );
    injector.map<PushTimeUseCase>(
      (i) => PushTimeUseCaseImp(
        redmineGateway: i.get(),
        timeCacheGateway: i.get(),
      ),
    );
  }
}
