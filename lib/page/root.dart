import 'package:aspis/design/button.dart';
import 'package:aspis/design/theme.dart';
import 'package:aspis/page/login.dart';
import 'package:aspis/page/screen/change_password.dart';
import 'package:aspis/page/screen/home.dart';
import 'package:aspis/page/screen/mypage.dart';
import 'package:aspis/page/screen/vision.dart';
import 'package:flutter/material.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  final _controller = PageController();
  bool _isOverlayShowing = false;
  bool _isMenuVisible = false;

  void _moveTo(int index) => _controller.jumpToPage(index);
  void _push(Widget page) => Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  void _replace(Widget page) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => page));

  Widget _buildTabItem({
    required String label,
    required String iconPath,
    required Size size,
    required double gap,
    required VoidCallback onPressed
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(iconPath, width: size.width, height: size.height),
          SizedBox(height: gap),
          Text(label, style: TextStyle(
            fontSize: 10,
            fontWeight: Weight.bold
          ))
        ]
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            physics: NeverScrollableScrollPhysics(),
            children: [const Home(), const Vision(), const SizedBox(), const Mypage()]
          ),
          IgnorePointer(
            ignoring: !_isOverlayShowing,
            child: GestureDetector(
              onTap: () => setState(() {
                _isOverlayShowing = false;
                _isMenuVisible = false;
              }),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                color: _isOverlayShowing ? Color(0x66000000) : Colors.transparent,
                child: SizedBox.expand()
              )
            )
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeOut,
              height: _isOverlayShowing ? 375 : 80,
              padding: EdgeInsets.only(bottom: 10, top: _isMenuVisible ? 0 : 18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                border: Border(
                  right: BorderSide(color: Color(0xFFE1E1E1), width: 2),
                  left: BorderSide(color: Color(0xFFE1E1E1), width: 2),
                  top: BorderSide(color: Color(0xFFE1E1E1), width: 2)
                )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (_isMenuVisible)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('반갑습니다, 사용자님', style: TextStyle(
                            fontSize: 20,
                            fontWeight: Weight.bold,
                            height: 1
                          )),
                          const SizedBox(height: 5),
                          Text('umjunsik@dsm.hs.kr', style: TextStyle(fontSize: 12, height: 1)),
                          const SizedBox(height: 30),
                          SheetButton(iconPath: 'assets/user.png', text: '기본 정보', onPressed: () => _moveTo(3)),
                          const SizedBox(height: 20),
                          SheetButton(iconPath: 'assets/lock.png', text: '비밀번호 변경', onPressed: () => _push(const ChangePassword())),
                          const SizedBox(height: 20),
                          SheetButton(iconPath: 'assets/logout.png', text: '로그아웃', onPressed: () => _replace(const Login())),
                          const SizedBox(height: 34)
                        ]
                      )
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildTabItem(
                        label: '홈',
                        iconPath: 'assets/home.png',
                        size: const Size(24, 24),
                        gap: 6,
                        onPressed: () => _moveTo(0)
                      ),
                      _buildTabItem(
                        label: '비전',
                        iconPath: 'assets/camera.png',
                        size: const Size(25, 25),
                        gap: 3,
                        onPressed: () => _moveTo(1)
                      ),
                      _buildTabItem(
                        label: '관리',
                        iconPath: 'assets/book.png',
                        size: const Size(22, 22),
                        gap: 6,
                        onPressed: () {}
                      ),
                      _buildTabItem(
                        label: '상세',
                        iconPath: 'assets/menu.png',
                        size: const Size(35, 24),
                        gap: 7,
                        onPressed: () => setState(() {
                          if (_isOverlayShowing && !_isMenuVisible) return;
                          _isOverlayShowing = !_isOverlayShowing;
                          if (_isOverlayShowing) {
                            Future.delayed(
                              Duration(milliseconds: 200),
                              () {
                                if (!_isOverlayShowing) return;
                                setState(() => _isMenuVisible = true);
                              }
                            );
                          } else {
                            _isMenuVisible = false;
                          }
                        })
                      )
                    ]
                  )
                ]
              )
            )
          )
        ]
      )
    ));
  }
}
