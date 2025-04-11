import 'package:aspis/core/dio.dart';
import 'package:dio/dio.dart';

abstract class Service {
  final Dio dio;
  Service(Server server) : dio = instanceMap[server]!;
}