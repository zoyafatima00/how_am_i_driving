import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));
String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.username,
    this.email,
    this.image,
    this.token,
  });

  LoginModel.fromJson(dynamic json) {
    username = json['username'];
    email = json['email'];
    image = json['image'];
    token = json['token'];
  }
  String? username;
  String? email;
  String? image;
  String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['username'] = username;
    map['email'] = email;
    map['image'] = image;
    map['token'] = token;
    return map;
  }
}
