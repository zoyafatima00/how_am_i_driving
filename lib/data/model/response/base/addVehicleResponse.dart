import 'dart:convert';

// Function to parse the response
AddVehicleResponse addVehicleResponseFromJson(String str) =>
    AddVehicleResponse.fromJson(json.decode(str));

// Function to convert the object to JSON
String addVehicleResponseToJson(AddVehicleResponse data) =>
    json.encode(data.toJson());

class AddVehicleResponse {
  AddVehicleResponse({
    this.message,
    this.vehicleId,
  });

  // Factory method to create AddVehicleResponse from JSON
  AddVehicleResponse.fromJson(dynamic json) {
    message = json['message'];
    vehicleId = json['vehicle_id'];
  }

  // Fields
  String? message;
  int? vehicleId; // Assuming the vehicle ID is an integer

  // Method to convert AddVehicleResponse to JSON
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['vehicle_id'] = vehicleId;
    return map;
  }
}
