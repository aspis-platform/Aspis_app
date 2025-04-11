import 'package:flutter/material.dart';

abstract class NavigatorManager {
  static final navigatorKey = GlobalKey<NavigatorState>();
  static NavigatorState get navigator => Navigator.of(navigatorKey.currentContext!);
}