import 'dart:developer';

import 'package:chaty/src/models/user.dart';
import 'package:chaty/src/preferences/prefs.dart';
import 'package:chaty/src/providers/base_provider.dart';
import 'package:chaty/src/services/auth_service.dart';
import 'package:dio/dio.dart';

class AuthProvider extends BaseProvider {
  AuthProvider(String? token) : super(token);
  late User _user;
  User get user => _user;
  setUser(User user) {
    _user = user;
    notifyListeners();
  }

  setAccessToken(String token) {
    Prefs.instance.setToken(token);
    api.token = token;
    notifyListeners();
  }

  getToken() async {
    String? token = await Prefs.instance.getToken();
    api.token = token;
    notifyListeners();
  }

  Future<bool> checkName(String name) async {
    try {
      Response res = await AuthService.instance.checkName(name);
      if (res.statusCode == 200) {
        if (res.data['user'] != null) {
          return false;
        }
        return true;
      }
      return true;
    } on DioError catch (e) {
      log("error: ${e.response?.data}");
      return true;
    }
  }

  Future<bool> getUser() async {
    try {
      final Response response = await AuthService.instance.getUser();
      if (response.statusCode == 200) {
        setUser(User.fromMap(response.data['user']));
        return true;
      } else {
        log('getUser: ${response.statusCode}');
        return false;
      }
    } on DioError catch (e) {
      log('getUser: ${e.response?.data}');
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      Response res = await AuthService.instance.login(email, password);
      if (res.statusCode == 200) {
        setUser(User.fromMap(res.data['user']));
        setAccessToken(res.data['access_token']);
        return true;
      }
      return false;
    } on DioError catch (error) {
      log(error.response.toString());
      if (error.response!.statusCode == 403) {
        setError("Invalid email or password");
      }
      return false;
    }
  }

  Future<bool> register(String name, String email, String password) async {
    try {
      Response res = await AuthService.instance.register(name, email, password);
      if (res.statusCode == 201) {
        setUser(User.fromMap(res.data['user']));
        setAccessToken(res.data['access_token']);
        return true;
      }
      return false;
    } catch (error) {
      log(error.toString());
      return false;
    }
  }
}
