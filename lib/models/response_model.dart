import '../utils/constants.dart';

class ResponseModel {
  ResponseStatus responseStatus;
  int statusCode;
  String message;
  Map<String, dynamic> object;

  ResponseModel({
    required this.responseStatus,
    required this.statusCode,
    required this.message,
    required this.object,
  });
}
