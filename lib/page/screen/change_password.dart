import 'package:aspis/design/button.dart';
import 'package:aspis/design/header.dart';
import 'package:aspis/design/input.dart';
import 'package:aspis/design/theme.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  String _pastPassword = '';
  String _newPassword = '';
  String _newPasswordCheck = '';
  bool _isPastPasswordSecure = true;
  bool _isNewPasswordSecure = true;
  bool _isNewPasswordCheckSecure = true;

  void _pop() => Navigator.pop(context);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Header(),
          const SizedBox(width: 8),
          Text('비밀번호 변경', style: TextStyle(
            fontSize: 20,
            fontWeight: Weight.bold
          )),
          const SizedBox(height: 60),
          InputScope(
            label: '기존 비밀번호',
            input: Input(
              onChanged: (value) => setState(() => _pastPassword = value),
              isSecure: _isPastPasswordSecure,
              placeholder: '기존 비밀번호를 입력하세요',
              actionPadding: EdgeInsets.only(top: 18.5, bottom: 18.5),
              actionWidget: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: ()=>setState(() => _isPastPasswordSecure = !_isPastPasswordSecure),
                child: _isPastPasswordSecure
                  ? Image.asset('assets/visible.png', width: 16, height: 12)
                  : Transform.scale(scale: 1.5, child: Image.asset('assets/invisible.png', height: 12))
              )
            )
          ),
          const SizedBox(height: 28),
          InputScope(
            label: '새로운 비밀번호',
            input: Input(
              onChanged: (value) => setState(() => _newPassword = value),
              isSecure: _isNewPasswordSecure,
              placeholder: '새 비밀번호를 입력하세요',
              actionPadding: EdgeInsets.only(top: 18.5, bottom: 18.5),
              actionWidget: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: ()=>setState(() => _isNewPasswordSecure = !_isNewPasswordSecure),
                child: _isNewPasswordSecure
                  ? Image.asset('assets/visible.png', width: 16, height: 12)
                  : Transform.scale(scale: 1.5, child: Image.asset('assets/invisible.png', height: 12))
              )
            )
          ),
          const SizedBox(height: 28),
          InputScope(
            label: '비밀번호 확인',
            input: Input(
              onChanged: (value) => setState(() => _newPasswordCheck = value),
              isSecure: _isNewPasswordCheckSecure,
              placeholder: '새 비밀번호를 다시 입력하세요',
              actionPadding: EdgeInsets.only(top: 18.5, bottom: 18.5),
              actionWidget: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: ()=>setState(() => _isNewPasswordCheckSecure = !_isNewPasswordCheckSecure),
                child: _isNewPasswordCheckSecure
                  ? Image.asset('assets/visible.png', width: 16, height: 12)
                  : Transform.scale(scale: 1.5, child: Image.asset('assets/invisible.png', height: 12))
              )
            )
          ),
          const Spacer(),
          Button(
            '변경하기',
            onPressed: _pop,
            enable: _pastPassword.isNotEmpty
              && _newPassword.isNotEmpty
              && _newPasswordCheck.isNotEmpty
          ),
          const SizedBox(height: 24)
        ]
      )
    );
  }
}
