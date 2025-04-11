import 'package:aspis/core/env.dart';
import 'package:aspis/core/manager.dart';
import 'package:aspis/page/login.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final _storage = FlutterSecureStorage();
Future<String> _getAccessToken() async {
  return await _storage.read(key: 'accessToken') ?? '';
}
Future<String> _getRefreshToken() async {
  return await _storage.read(key: 'refreshToken') ?? '';
}
Future<void> _setAccessToken(String token) async {
  await _storage.write(key: 'accessToken', value: token);
}
Future<void> _setRefreshToken(String token) async {
  await _storage.write(key: 'refreshToken', value: token);
}

final _authenticationInterceptor = InterceptorsWrapper(
  onRequest: (options, handler) async {
    final accessToken = _getAccessToken();
    options.headers['Authorization'] = 'Bearer $accessToken';
    return handler.next(options);
  },
  onError: (error, handler) async {
    if (error.response?.statusCode == 401) {
      final refreshToken = _getRefreshToken();
      final res = await Dio().post('$AUTH_URL/auth/reissue', data: {
        'refresh_token': refreshToken
      });
      if (res.statusCode == 401) {
        await _storage.deleteAll();
        NavigatorManager.navigator.push(MaterialPageRoute(builder: (context) => Login()));
        return;
      }
      _setAccessToken(res.data['access_token']);
      final originOption = error.requestOptions;
      final resolver = await Dio().request(
        originOption.path,
        options: Options(
          method: originOption.method,
          headers: originOption.headers,
          receiveTimeout: originOption.receiveTimeout,
          contentType: originOption.contentType,
          extra: originOption.extra,
          responseType: originOption.responseType
        ),
        data: originOption.data,
        queryParameters: originOption.queryParameters
      );
      return handler.resolve(resolver);
    }
    return handler.next(error);
  }
);

enum Server {
  core,
  auth,
  upload,
  ai;

  String get url => switch(this) {
    Server.core => CORE_URL,
    Server.auth => AUTH_URL,
    Server.upload => UPLOAD_URL,
    Server.ai => AI_URL
  };
}

Dio _createDio(Server server) {
  final dio = Dio(BaseOptions(
    baseUrl: server.url,
    connectTimeout: Duration(seconds: 10),
    receiveTimeout: Duration(minutes: 2)
  ));
  dio.interceptors.add(_authenticationInterceptor);
  return dio;
}

final instanceMap = <Server, Dio>{
  Server.core: _createDio(Server.core),
  Server.auth: _createDio(Server.auth),
  Server.upload: _createDio(Server.upload),
  Server.ai: _createDio(Server.ai)
};

Future<void> login({required String accessToken, required String refreshToken}) async {
  await _setAccessToken(accessToken);
  await _setRefreshToken(refreshToken);
}

Future<void> logout() async {
  await _storage.deleteAll();
}