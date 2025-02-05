import 'dart:convert';

SignUpBody signUpBodyFromJson(String str) =>
    SignUpBody.fromJson(json.decode(str));
String signUpBodyToJson(SignUpBody data) => json.encode(data.toJson());

class SignUpBody {
  SignUpBody({
    this.username,
    this.email,
    this.password,
    this.confirmPassword,
    this.city,
    this.contactNumber,
    this.designation,
    this.imageBase64,
  });

  SignUpBody.fromJson(dynamic json) {
    username = json['username'];
    email = json['email'];
    password = json['password'];
    confirmPassword = json['confirmPassword'];
    imageBase64 = json['imageBase64'];
  }
  String? username;
  String? email;
  String? password;
  String? confirmPassword;
  String? imageBase64;
  String? designation;
  String? city;
  String? contactNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['username'] = username;
    map['email'] = email;
    map['password'] = password;
    map['confirmPassword'] = confirmPassword;
    map['imageBase64'] = imageBase64;
    return map;
  }
}
