import 'package:aspis/design/logo.dart';
import 'package:aspis/page/login.dart';
import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    void next() => Navigator.push(context, MaterialPageRoute(builder: (_) => Login()));
    Future.delayed(
      const Duration(seconds: 1),
      next
    );
    return Scaffold(
      body: Center(
        child: Logo(isFit: false, width: 82)
      )
    );
  }
}
