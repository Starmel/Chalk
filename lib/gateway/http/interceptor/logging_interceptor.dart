import 'dart:core';

import 'package:http_interceptor/http_methods.dart';
import 'package:http_interceptor/interceptor_contract.dart';
import 'package:http_interceptor/models/request_data.dart';
import 'package:http_interceptor/models/response_data.dart';

class LoggingInterceptor implements InterceptorContract {
  LoggingInterceptor();

  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    print("");
    print(">> ${methodToString(data.method).toUpperCase()} ${data.url}");
    data.headers.forEach(
      (key, value) => print(">> Header: \"$key\" : \"$value\""),
    );
    print(">> Body: ${data.body}");

    return Future.value(data);
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) {
    print("");
    print("<< Response code: ${data.statusCode}");
    print("<< ${methodToString(data.method).toUpperCase()} ${data.url}");
    data.headers.forEach(
      (key, value) => print("<< Header: \"$key\" : \"$value\""),
    );
    print("<< Body: ${data.body}");

    return Future.value(data);
  }
}
