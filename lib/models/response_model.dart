import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/constants.dart';
part 'response_model.freezed.dart';
part 'response_model.g.dart';

@unfreezed
class ResponseModel with _$ResponseModel {

  factory ResponseModel({
    @Default(ResponseStatus.SAVED) ResponseStatus responseStatus,
   @Default(200) int statusCode,
   @Default('saved') String message,
   @Default({}) Map<String, dynamic> object,
}) = _ResponseModel;

  factory ResponseModel.fromJson(Map<String, dynamic> json) => _$ResponseModelFromJson(json);
}
