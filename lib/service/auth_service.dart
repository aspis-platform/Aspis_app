import 'package:aspis/core/dio.dart';
import 'package:aspis/model/user_info_response.dart';
import 'package:aspis/service/service.dart';

class AuthService extends Service {
  static final AuthService _instance = AuthService._();

  AuthService._() : super(Server.auth);
  factory AuthService() => _instance;

  Future<bool> signIn({required String email, required String password}) async {
    try {
      final response = await dio.post(
        '/user/login',
        data: {
          'user_email': email,
          'user_password': password
        }
      );
      Map<String, String> data = response.data;
      await login(accessToken: data['access_token']!, refreshToken: data['refresh_token']!);
      return true;
    } catch (e) {
      return false;
    }
  }
  
  Future<bool> rename({required name}) async {
    try {
      final response = await dio.patch(
        '/user/update/profile',
        data: {
          "user_name": name
        }
      );
      print(response.data);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> changePassword({required password, required newPassword}) async {
    try {
      final response = await dio.patch(
        '/user/update/password',
        data: {
          "user_old_password": password,
          "user_new_password": newPassword
        }
      );
      print(response.data);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<UserInfoResponse?> getUserInfo() async {
    try {
      final response = await dio.get('/auth/me');
      return UserInfoResponse.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }
}