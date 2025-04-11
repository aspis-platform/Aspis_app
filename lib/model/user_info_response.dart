class UserInfoResponse {
  final String id;
  final String email;
  final String name;

  const UserInfoResponse({
    required this.id,
    required this.email,
    required this.name
  });

  factory UserInfoResponse.fromJson(Map<String, dynamic> json) {
    return UserInfoResponse(
      id: json['userId'],
      email: json['userEmail'],
      name: json['userName']
    );
  }
}