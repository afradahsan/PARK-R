import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Vehicle {
  final String vehicleName;
  final String vehicleNumber;
  final String vehicleType;
  String? id;
  Vehicle({
    required this.vehicleName,
    required this.vehicleNumber,
    required this.vehicleType,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'vehicleName': vehicleName,
      'vehicleNumber': vehicleNumber,
      'vehicleType': vehicleType,
      '_id': id,
    };
  }

  factory Vehicle.fromMap(Map<String, dynamic> map) {
    return Vehicle(
      vehicleName: map['vehicleName'] as String,
      vehicleNumber: map['vehicleNumber'] as String,
      vehicleType: map['vehicleType'] as String,
      id: map['_id'] != null ? map['_id'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      vehicleName: json['vehicleName'] ?? '',
      vehicleNumber: json['vehicleNumber'] ?? '',
      vehicleType: json['vehicleType'] ?? '',
      id: json['_id'] ?? '',
    );
  }
}
