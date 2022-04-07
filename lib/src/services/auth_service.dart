import 'dart:developer';

import 'package:chaty/src/services/base_api.dart';
import 'package:dio/dio.dart';

class AuthService extends BaseApi {
  AuthService._privateConstructor();
  static AuthService instance = AuthService._privateConstructor();

  Future<Response> checkName(String name) {
    return api.httpGet('/name/$name');
  }

  Future<Response> getUser() async {
    return api.httpGet('/users/auth');
  }

  Future<Response> login(String email, String password) async {
    return api
        .httpPost("/login", {'email': email.trim(), 'password': password});
  }

  Future<Response> register(String name, String email, String password) async {
    return api.httpPost("/signup", {
      'name': name.trim(),
      'email': email.trim(),
      'password': password.trim()
    }).catchError((error) {
      log(error.toString());
    });
  }
}
