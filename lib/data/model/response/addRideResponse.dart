import 'dart:convert';

AddRideResponse addRideResponseFromJson(String str) =>
    AddRideResponse.fromJson(json.decode(str));
String signUpResponseToJson(AddRideResponse data) => json.encode(data.toJson());

class AddRideResponse {
  AddRideResponse({
    this.message,
  });

  AddRideResponse.fromJson(dynamic json) {
    message = json['message'];
  }
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    return map;
  }
}
