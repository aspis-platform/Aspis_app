import 'package:aspis/core/dio.dart';
import 'package:aspis/service/service.dart';

class AuthService extends Service {
  static final AuthService _instance = AuthService._();

  AuthService._() : super(Server.auth);
  factory AuthService() => _instance;
}