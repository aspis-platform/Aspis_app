import 'package:aspis/design/button.dart';
import 'package:aspis/design/input.dart';
import 'package:aspis/design/logo.dart';
import 'package:aspis/design/theme.dart';
import 'package:aspis/page/root.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _email = '';
  String _password = '';
  bool _secure = true;

  void _next() => Navigator.push(context, MaterialPageRoute(builder: (_) => Root()));

  void _login() {
    _next();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.only(
          top: 60,
          bottom: 57,
          left: 28,
          right: 28
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Logo(width: 60),
            const SizedBox(height: 12),
            Text('아스피스', style: TextStyle(
              color: Palette.sub4,
              fontSize: 24,
              fontWeight: Weight.bold
            )),
            const SizedBox(height: 7),
            Text('아스피스에 로그인 하세요', style: TextStyle(
              color: Color(0xFF626161),
              fontSize: 18
            )),
            const SizedBox(height: 56),
            InputScope(
              label: '이메일',
              input: Input(
                onChanged: (value) => setState(() => _email = value),
                placeholder: '이메일을 입력하세요'
              ),
            ),
            const SizedBox(height: 32),
            InputScope(
              label: '비밀번호',
              input: Input(
                onChanged: (value) => setState(() => _password = value),
                isSecure: _secure,
                placeholder: '비밀번호를 입력하세요',
                actionPadding: EdgeInsets.only(top: 18.5, bottom: 18.5),
                actionWidget: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: ()=>setState(() => _secure = !_secure),
                  child: _secure
                    ? Image.asset('assets/visible.png', width: 16, height: 12)
                    : Transform.scale(scale: 1.5, child: Image.asset('assets/invisible.png', height: 12))
                )
              ),
            ),
            const Spacer(),
            Button('완료', onPressed: _login, enable: _email.isNotEmpty && _password.isNotEmpty)
          ]
        )
      )
    );
  }
}
