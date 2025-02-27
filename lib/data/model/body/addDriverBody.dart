class AddDriverBody {
  AddDriverBody({
    this.fullName,
    this.email,
    this.cnic,
    this.dob,
    this.address,
    this.city,
    this.contactNumber,
    this.licenseNumber,
    this.dateOfIssue,
    this.dateOfExpiry,
    this.experience,
  });

  // Constructor to create AddDriverBody from JSON
  AddDriverBody.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    email = json['email'];
    cnic = json['cnic'];
    dob = json['dob'];
    address = json['address'];
    city = json['city'];
    contactNumber = json['contact_number'];
    licenseNumber = json['license_number'];
    dateOfIssue = json['date_of_issue'];
    dateOfExpiry = json['date_of_expiry'];
    experience = json['experience'];
  }

  // Fields
  String? fullName;
  String? email;
  String? cnic;
  String? dob; // Store as string in the format "dd/MM/yyyy"
  String? address;
  String? city;
  String? contactNumber;
  String? licenseNumber;
  String? dateOfIssue; // Store as string in the format "dd/MM/yyyy"
  String? dateOfExpiry; // Store as string in the format "dd/MM/yyyy"
  String? experience;

  // Convert AddDriverBody to JSON with the correct field names (matching the API)
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['full_name'] = fullName;
    map['email'] = email;
    map['cnic'] = cnic;
    map['dob'] = dob;
    map['address'] = address;
    map['city'] = city;
    map['contact_number'] = contactNumber;
    map['license_number'] = licenseNumber;
    map['date_of_issue'] = dateOfIssue;
    map['date_of_expiry'] = dateOfExpiry;
    map['experience'] = experience;
    return map;
  }
}
