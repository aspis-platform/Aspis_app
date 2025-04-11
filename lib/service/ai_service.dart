import 'dart:typed_data';

import 'package:aspis/core/dio.dart';
import 'package:aspis/model/diagnosis_response.dart';
import 'package:aspis/service/service.dart';
import 'package:dio/dio.dart';

class AIService extends Service {
  static final AIService _instance = AIService._();

  AIService._() : super(Server.ai);
  factory AIService() => _instance;

  Future<DiagnosisResponse> analyze(Uint8List data) async {
    try {
      final response = await dio.post(
        '/v1/analyze',
        data: FormData.fromMap({
          'file': MultipartFile.fromBytes(
            data,
            filename: 'dog_image.jpg',
            contentType: DioMediaType.parse('image/jpeg')
          )
        })
      );
      return DiagnosisResponse.fromJson(response.data);
    } catch (e) {
      return DiagnosisResponse(success: false, error: "네트워크 오류", message: e.toString());
    }
  }
}