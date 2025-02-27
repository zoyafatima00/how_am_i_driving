import 'dart:convert';

SignUpBody signUpBodyFromJson(String str) =>
    SignUpBody.fromJson(json.decode(str));

String signUpBodyToJson(SignUpBody data) => json.encode(data.toJson());

class SignUpBody {
  SignUpBody({
    this.fullName,
    this.email,
    this.cnic,
    this.dob,
    this.address,
    this.city,
    this.contactNumber,
    this.designation,
    this.password,
    this.confirmPassword,
  });

  // Constructor to create SignUpBody from JSON
  SignUpBody.fromJson(dynamic json) {
    fullName = json['full_name'];
    email = json['email'];
    cnic = json['cnic'];
    dob = json['dob'];
    address = json['address'];
    city = json['city'];
    contactNumber = json['contact_number'];
    designation = json['designation'];
    password = json['password'];
    confirmPassword = json['confirm_password'];
  }

  // Fields
  String? fullName;
  String? email;
  String? cnic;
  String? dob;
  String? address;
  String? city;
  String? contactNumber;
  String? designation;
  String? password;
  String? confirmPassword;

  // Convert SignUpBody to JSON with the correct field names (matching the API)
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['full_name'] = fullName;
    map['email'] = email;
    map['cnic'] = cnic;
    map['dob'] = dob;
    map['address'] = address;
    map['city'] = city;
    map['contact_number'] = contactNumber;
    map['designation'] = designation;
    map['password'] = password;
    map['confirm_password'] = confirmPassword;
    return map;
  }
}
