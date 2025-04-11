import 'package:aspis/design/header.dart';
import 'package:aspis/design/input.dart';
import 'package:aspis/design/theme.dart';
import 'package:flutter/material.dart';

class Mypage extends StatefulWidget {
  const Mypage({super.key});

  @override
  State<Mypage> createState() => _MypageState();
}

class _MypageState extends State<Mypage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String _name = '';
  String _savedName = '';
  bool _isBannerShowing = false;

  void _onChangedName(String value) {
    setState(() => _name = value);
    final messenger = ScaffoldMessenger.of(context);
    if (_name == _savedName) {
      messenger.clearMaterialBanners();
      _isBannerShowing = false;
      return;
    }
    if (_isBannerShowing) return;
    _isBannerShowing = true;
    messenger.showMaterialBanner(
      MaterialBanner(
        content: Text('저장되지 않은 변경사항이 있어요.'),
        actions: [
          TextButton(
            onPressed: () {
              setState(() => _savedName = _name);
              messenger.removeCurrentMaterialBanner();
              _isBannerShowing = false;
            },
            child: Text('저장')
          )
        ]
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        children: [
          Header(),
          const SizedBox(width: 8),
          Text('기본 정보', style: TextStyle(
            fontSize: 20,
            fontWeight: Weight.bold
          )),
          const SizedBox(height: 60),
          InputScope(
            label: '이메일',
            input: Input(
              onChanged: (_) {},
              controller: _emailController,
              enabled: false
            )
          ),
          const SizedBox(height: 28),
          InputScope(
            label: '이름',
            input: Input(
              onChanged: _onChangedName,
              controller: _nameController,
              placeholder: '이름을 입력하세요',
              actionPadding: EdgeInsets.only(top: 18.5, bottom: 18.5),
              actionWidget: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  _nameController.clear();
                  _onChangedName('');
                  },
                  child: Image.asset('assets/delete.png', width: 15, height: 15)
              )
            )
          )
        ]
      )
    );
  }
}
