import 'dart:io';

import 'package:dio/dio.dart';

//const String BASE_URL = "https://aiota.live/sauftrag/API/";
const String BASE_URL = "https://sauftragsocial.herokuapp.com/";

class DioService {
  static Dio? _dio;
  DioService() {
    _dio = Dio();
    _dio!.options.baseUrl = BASE_URL;
    _dio!.options.connectTimeout = 30000;
    _dio!.options.receiveTimeout = 30000;

    _dio!.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          // Do something before request is sent
          print('onRequest');
          print(options.path);
          print(options.method);
          _dio!.options.headers.putIfAbsent(
              HttpHeaders.acceptHeader, () => Headers.jsonContentType);
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print('onResponse');
          print(response.statusCode);
          print(response.requestOptions.path);
          print('success: ${response.data['success']}');
          print('message: ${response.data['message']}');
          return handler.next(response);
        },
        onError: (DioError error, ErrorInterceptorHandler handler) {
          if (error.response?.statusCode == 401) {
            print('DioError - trying again - ${error.response?.statusCode}');
            print(error.error ?? 'NUll from dioerror');
          } else {
            print(error.response?.statusCode);
            print(error.message);
          }
          return handler.next(error);
        },
      ),
    );
  }
  static Dio getInstance() {
    if (_dio == null) {
      DioService();
      return _dio!;
    }
    return _dio!;
  }
}