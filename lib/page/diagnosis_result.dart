import 'dart:typed_data';

import 'package:aspis/design/display_layout.dart';
import 'package:aspis/design/theme.dart';
import 'package:aspis/model/diagnosis_response.dart';
import 'package:flutter/material.dart';

class DiagnosisResult extends StatelessWidget {
  final Uint8List imageBytes;
  final DiagnosisResponse response;
  const DiagnosisResult({super.key, required this.imageBytes, required this.response});

  @override
  Widget build(BuildContext context) {
    return DisplayLayout(
      title: 'AI 강아지 건강 예측',
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: MediaQuery.sizeOf(context).height),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.memory(imageBytes),
              const SizedBox(height: 13),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('assets/logo_ai.png', width: 160),
                    const SizedBox(height: 4),
                    Text('진단 결과', style: TextStyle(
                      color: Palette.sub2,
                      fontSize: 16,
                      fontWeight: Weight.medium
                    )),
                    const SizedBox(height: 10),
                    Text(response.data!.disease, style: TextStyle(
                      fontSize: 15,
                      fontWeight: Weight.medium
                    )),
                    const SizedBox(height: 4),
                    Text(response.data!.info.symptoms, style: TextStyle(
                      fontSize: 14,
                      fontWeight: Weight.medium
                    )),
                    const SizedBox(height: 14),
                    Text('대처법', style: TextStyle(
                      color: Palette.sub2,
                      fontSize: 16,
                      fontWeight: Weight.medium
                    )),
                    const SizedBox(height: 10),
                    Text(response.data!.info.recommendations, style: TextStyle(
                      fontSize: 15,
                      fontWeight: Weight.medium
                    )),
                    const SizedBox(height: 60),
                    if (response.data!.info.vetVisitRequired) Text('수의사 방문이 필요합니다. 동물병원을 방문하세요.', style: TextStyle(
                      color: Palette.red,
                      fontSize: 14,
                      fontWeight: Weight.medium
                    )),
                    const SizedBox(height: 20)
                  ]
                )
              )
            ]
          )
        )
      )
    );
  }
}
