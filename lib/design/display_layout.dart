import 'package:aspis/core/manager.dart';
import 'package:aspis/design/theme.dart';
import 'package:flutter/material.dart';

class DisplayLayout extends StatelessWidget {
  final String title;
  final Widget child;
  const DisplayLayout({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _Header(title: title),
      body: child
    ));
  }
}

class _Header extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const _Header({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 72,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => NavigatorManager.navigator.pop(),
                child: Image.asset(
                  'assets/back.png',
                  width: 56,
                  height: 56
                )
              )
            ]
          ),
          Center(
            child: Text(title, style: TextStyle(
              fontSize: 20,
              fontWeight: Weight.medium
            ))
          )
        ]
      )
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(72);
}
