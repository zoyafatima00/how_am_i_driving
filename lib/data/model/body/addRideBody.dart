class AddRideBody {
  AddRideBody({
    this.driverName,
    this.driverId,
    this.vehicleName,
    this.vehicleNumber,
    this.date,
    this.time,
    this.task,
    this.address,
    this.supervisor,
    this.allocatedTimeForTask,
  });

  // Constructor to create AddRideBody from JSON
  AddRideBody.fromJson(Map<String, dynamic> json) {
    driverName = json['driver_name'];
    driverId = json['driver_id'];
    vehicleName = json['vehicle_name'];
    vehicleNumber = json['vehicle_number'];
    date = json['date']; // Store as string in the format "dd/MM/yyyy"
    time = json['time'];
    task = json['task'];
    address = json['address'];
    supervisor = json['supervisor'];
    allocatedTimeForTask = json['allocated_time_for_task'];
  }

  // Fields
  String? driverName;
  String? driverId;
  String? vehicleName;
  String? vehicleNumber;
  String? date; // Store as string in the format "dd/MM/yyyy"
  String? time;
  String? task;
  String? address;
  String? supervisor;
  String? allocatedTimeForTask;

  // Convert AddRideBody to JSON with the correct field names (matching the API)
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['driver_name'] = driverName;
    map['driver_id'] = driverId;
    map['vehicle_name'] = vehicleName;
    map['vehicle_number'] = vehicleNumber;
    map['date'] = date; // Ensure the date is in the format "dd/MM/yyyy"
    map['time'] = time;
    map['task'] = task;
    map['address'] = address;
    map['supervisor'] = supervisor;
    map['allocated_time_for_task'] = allocatedTimeForTask;
    return map;
  }
}
