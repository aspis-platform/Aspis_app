import 'package:aspis/core/manager.dart';
import 'package:aspis/design/theme.dart';
import 'package:aspis/page/splash.dart';
import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    navigatorKey: NavigatorManager.navigatorKey,
    theme: ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'WantedSans',
      colorSchemeSeed: Palette.sub2,
    ),
    home: DefaultTextStyle(
      style: TextStyle(
        height: 1,
        fontWeight: Weight.regular
      ),
      child: Splash()
    )
  )
);