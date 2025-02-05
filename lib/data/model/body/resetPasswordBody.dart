import 'dart:convert';

ResetPasswordBody resetPasswordBodyFromJson(String str) =>
    ResetPasswordBody.fromJson(json.decode(str));
String resetPasswordBodyToJson(ResetPasswordBody data) =>
    json.encode(data.toJson());

class ResetPasswordBody {
  ResetPasswordBody({
    this.email,
    this.newPassword,
    this.confirmPassword,
  });

  ResetPasswordBody.fromJson(dynamic json) {
    email = json['email'];
    newPassword = json['newPassword'];
    confirmPassword = json['confirmPassword'];
  }
  String? email;
  String? newPassword;
  String? confirmPassword;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['newPassword'] = newPassword;
    map['confirmPassword'] = confirmPassword;
    return map;
  }
}
