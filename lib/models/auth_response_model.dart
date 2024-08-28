class AuthResponseModel {
  int statusCode;
  String message;
  String accessToken;
  int logInTime;
  int expirationDuration;

  AuthResponseModel({
    required this.statusCode,
    required this.message,
    required this.accessToken,
    required this.logInTime,
    required this.expirationDuration,
  });
}
