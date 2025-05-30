class VerifyOtpResponse {
  final String token;
  final User user;
  final bool hasError;

  VerifyOtpResponse({
    required this.token,
    required this.user,
    required this.hasError,
  });

  factory VerifyOtpResponse.fromJson(Map<String, dynamic> json) {
    return VerifyOtpResponse(
      token: json['token'] ?? '',
      user: User.fromJson(json['user']),
      hasError: json['hasError'] ?? true,
    );
  }
}

class User {
  final int id;
  final String? name;
  final String? userType;
  final String? mobileNumber;
  final int userStatus;
  final String profilePhotoUrl;

  User({
    required this.id,
    this.name,
    required this.userType,
    this.mobileNumber,
    required this.userStatus,
    required this.profilePhotoUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      userType: json['user_type'],
      mobileNumber: json['mobile_number'],
      userStatus: json['user_status'],
      profilePhotoUrl: json['profile_photo_url'] ?? '',
    );
  }
}
