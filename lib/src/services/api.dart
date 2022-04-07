import 'dart:io';

import 'package:dio/dio.dart';

class Api {
  Api._();
  static final _api = Api._();
  factory Api() {
    return _api;
  }

  String? token;

  final Dio _dio = Dio(BaseOptions(
    baseUrl: "http://172.21.0.1:3000",
    connectTimeout: 60 * 1000, // 60 seconds
    receiveTimeout: 60 * 1000,
    headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
    },
  ));
  Future<Response> httpGet(String path) async {
    return await _dio.request(
      path,
      options: Options(method: "GET", headers: {
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: 'Bearer $token'
      }),
    );
  }

  Future<Response> httpPost(String path, Map<String, dynamic> body) async {
    return await _dio.request(
      path,
      data: body,
      options:
          Options(method: "POST", contentType: "application/json", headers: {
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: 'Barear $token'
      }),
    );
  }

  Future<Response> httpPut(String path, Map<String, dynamic> body) async {
    return await _dio.put(
      path,
      data: body,
      options:
          Options(method: "PUT", contentType: "application/json", headers: {
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: 'Barear $token'
      }),
    );
  }

  Future<Response> httpDelete(String path) async {
    return await _dio.delete(
      path,
      options: Options(method: "DELETE", headers: {
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: 'Barear $token'
      }),
    );
  }

  Future<Response> httpPatch(String path, Map<String, dynamic> body) async {
    return await _dio.patch(
      path,
      data: body,
      options:
          Options(method: "PATCH", contentType: "application/json", headers: {
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: 'Barear $token'
      }),
    );
  }

  Future<Response> httpHead(String path) async {
    return await _dio.head(
      path,
      options: Options(method: "HEAD", headers: {
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: 'Barear $token'
      }),
    );
  }

  Future<Response> postWithFile(String path, File file) async {
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path, filename: fileName),
    });
    return await _dio.request(path,
        data: formData,
        options: Options(method: "POST", headers: {
          HttpHeaders.acceptHeader: "application/json",
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: 'Barear $token'
        }));
  }
}
