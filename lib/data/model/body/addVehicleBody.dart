class AddVehicleBody {
  AddVehicleBody({
    this.vehicleOwner,
    this.vehicleName,
    this.model,
    this.number,
    this.engineNumber,
    this.vehicleType,
    this.role,
    this.integration,
    this.milage,
    this.fuelType,
    this.dateOfJoining,
    this.addedBy,
    this.imageRear,
    this.imageFront,
    this.image3,
    this.image4,
    this.image5,
    this.image6,
  });

  // Constructor to create AddVehicleBody from JSON
  AddVehicleBody.fromJson(Map<String, dynamic> json) {
    vehicleOwner = json['vehicle_owner'];
    vehicleName = json['vehicle_name'];
    model = json['model'];
    number = json['number'];
    engineNumber = json['engine_number'];
    vehicleType = json['vehicle_type'];
    role = json['role'];
    integration = json['integration'];
    milage = json['milage'];
    fuelType = json['fuel_type'];
    dateOfJoining = json['date_of_joining'];
    addedBy = json['added_by'];
    imageRear = json['image_rear'];
    imageFront = json['image_front'];
    image3 = json['image_3'];
    image4 = json['image_4'];
    image5 = json['image_5'];
    image6 = json['image_6'];
  }

  // Fields
  String? vehicleOwner;
  String? vehicleName;
  String? model;
  String? number;
  String? engineNumber;
  String? vehicleType;
  String? role;
  String? integration;
  double? milage;
  String? fuelType;
  String? dateOfJoining; // Store as string in the format "dd/MM/yyyy"
  String? addedBy;
  String? imageRear; // Assuming these fields are for image file paths or data
  String? imageFront;
  String? image3;
  String? image4;
  String? image5;
  String? image6;

  // Convert AddVehicleBody to JSON with the correct field names (matching the API)
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['vehicle_owner'] = vehicleOwner;
    map['vehicle_name'] = vehicleName;
    map['model'] = model;
    map['number'] = number;
    map['engine_number'] = engineNumber;
    map['vehicle_type'] = vehicleType;
    map['role'] = role;
    map['integration'] = integration;
    map['milage'] = milage;
    map['fuel_type'] = fuelType;
    map['date_of_joining'] = dateOfJoining;
    map['added_by'] = addedBy;
    map['image_rear'] = imageRear;
    map['image_front'] = imageFront;
    map['image_3'] = image3;
    map['image_4'] = image4;
    map['image_5'] = image5;
    map['image_6'] = image6;
    return map;
  }
}
