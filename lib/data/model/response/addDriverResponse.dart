import 'dart:convert';

AddDriverResponse addDriverResponseFromJson(String str) =>
    AddDriverResponse.fromJson(json.decode(str));
String signUpResponseToJson(AddDriverResponse data) =>
    json.encode(data.toJson());

class AddDriverResponse {
  AddDriverResponse({
    this.message,
  });

  AddDriverResponse.fromJson(dynamic json) {
    message = json['message'];
  }
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    return map;
  }
}
