import 'package:aspis/design/header.dart';
import 'package:aspis/design/theme.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget _buildBlock({required String title, required String content}) {
    return Flexible(child: Column(children: [
      Text(title, style: TextStyle(
        fontSize: 14,
        fontWeight: Weight.semiBold
      )),
      const SizedBox(height: 10),
      Container(
        width: double.infinity,
        height: 70,
        constraints: BoxConstraints(maxWidth: 110),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: Palette.sub2
          ),
          borderRadius: BorderRadius.circular(20)
        ),
        child: Center(
          child: Text(content, style: TextStyle(
            fontSize: 20,
            fontWeight: Weight.bold
          ))
        )
      )
    ]));
  }

  Widget _buildVisitorCount({required String today, required String yesterday, required String prevMonth}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 13, vertical: 14),
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: Palette.sub2
        ),
        borderRadius: BorderRadius.circular(5)
      ),
      child: Row(
        spacing: 28,
        children: [
          Row(
            spacing: 9,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('오늘', style: TextStyle(fontSize: 12)),
              Text(today, style: TextStyle(
                fontSize: 18,
                height: 1
              ))
            ]
          ),
          Row(
            spacing: 9,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('어제', style: TextStyle(fontSize: 12)),
              Text(yesterday, style: TextStyle(
                fontSize: 18,
                height: 1
              ))
            ]
          ),
          Row(
            spacing: 9,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('저번달', style: TextStyle(fontSize: 12)),
              Text(prevMonth, style: TextStyle(
                fontSize: 18,
                height: 1
              ))
            ]
          )
        ]
      )
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF81C2FF),
                Color(0x19FFFFFF),
                Colors.white,
                Colors.white
              ]
            )
          )
        ),
        SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Header(),
                  Text('안녕하세요,\n엄준식 님', style: TextStyle(
                    fontSize: 25,
                    fontWeight: Weight.bold
                  )),
                  const SizedBox(height: 15),
                  Text(
                    '엄준식 님 덕분에 아이들이 따뜻한 하루를 보내고 있어요.\n계속해서 함께해요!',
                    style: TextStyle(fontSize: 16)
                  ),
                  const SizedBox(height: 44),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildBlock(title: '보호중인 동물 수', content: '41 마리'),
                      _buildBlock(title: '임시보호율', content: '13%'),
                      _buildBlock(title: '분양 문의', content: '41 건')
                    ]
                  ),
                  const SizedBox(height: 32),
                  Text('홈페이지 방문자 추이', style: TextStyle(
                    fontSize: 14,
                    fontWeight: Weight.semiBold
                  )),
                  const SizedBox(height: 10),
                  _buildVisitorCount(today: '0.5천', yesterday: '0.2천', prevMonth: '0.4천'),
                  const Spacer(),
                  Center(child: Image.asset('assets/dog.png', width: 200, height: 200)),
                  const SizedBox(height: 100)
                ]
              )
            ),
          ),
        )
      ]
    );
  }
}
