class UserAuthApiResponse {
  final bool ok;
  final String message;
  final dynamic data;

  UserAuthApiResponse({
    required this.ok,
    required this.message,
    required this.data,
  });

  factory UserAuthApiResponse.fromJson(Map<String, dynamic> json) {
    return UserAuthApiResponse(
      ok: json['ok'] ?? false,
      message: json['message'] ?? '',
      data: json['data'],
    );
  }
}