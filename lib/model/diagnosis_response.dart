class DiagnosisResponse {
  final bool success;
  final DiagnosisData? data;
  final String? error;
  final String? message;
  final String? disclaimer;

  DiagnosisResponse({
    required this.success,
    this.data,
    this.error,
    this.message,
    this.disclaimer,
  });

  factory DiagnosisResponse.fromJson(Map<String, dynamic> json) {
    return DiagnosisResponse(
      success: json['success'],
      data: json['success'] ? DiagnosisData.fromJson(json['data']) : null,
      error: json['error'],
      message: json['message'],
      disclaimer: json['disclaimer'],
    );
  }
}

class DiagnosisData {
  final String disease;
  final DiagnosisInfo info;

  DiagnosisData({
    required this.disease,
    required this.info,
  });

  factory DiagnosisData.fromJson(Map<String, dynamic> json) {
    return DiagnosisData(
      disease: json['disease'],
      info: DiagnosisInfo.fromJson(json['info']),
    );
  }
}

class DiagnosisInfo {
  final String symptoms;
  final String recommendations;
  final bool vetVisitRequired;
  final String severity;

  DiagnosisInfo({
    required this.symptoms,
    required this.recommendations,
    required this.vetVisitRequired,
    required this.severity
  });

  factory DiagnosisInfo.fromJson(Map<String, dynamic> json) {
    return DiagnosisInfo(
      symptoms: json['symptoms'].runtimeType == String ? json['symptoms'] : List.from(json['symptoms']).join(', '),
      recommendations: json['recommendations'].runtimeType == String ? json['recommendations'] : List.from(json['recommendations']).join(', '),
      vetVisitRequired: json['vet_visit_required'],
      severity: json['severity']
    );
  }
}
