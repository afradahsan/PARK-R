// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ParkingModel {
  final String image;
  final String parkingName;
  final String locationName;
  final String position;
  final int totalSpots;
  final int carparkingFee;
  final int bikeparkingFee;
  final int truckparkingFee;
  final int? carwashFee;
  final bool indoor;
  final bool carWash;
  final bool evCharge;
  final bool? approved;
  String? id;

  ParkingModel({
    this.carwashFee,
    this.approved,
    required this.image,
    required this.parkingName,
    required this.locationName,
    required this.position,
    required this.totalSpots,
    required this.indoor,
    required this.carWash,
    required this.evCharge,
    required this.carparkingFee,
    required this.bikeparkingFee,
    required this.truckparkingFee,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image': image,
      'parkingName': parkingName,
      'locationName': locationName,
      'position': position,
      'totalSpots': totalSpots,
      'carparkingFee': carparkingFee,
      'bikeparkingFee': bikeparkingFee,
      'truckparkingFee': truckparkingFee,
      'carwashFee': carwashFee,
      'indoor': indoor,
      'carWash': carWash,
      'evCharge': evCharge,
      'id': id,
      'approved': approved
    };
  }

  factory ParkingModel.fromMap(Map<String, dynamic> map) {
    return ParkingModel(
      image: map['image'] as String,
      parkingName: map['parkingName'] as String,
      locationName: map['locationName'] as String,
      position: map['position'] as String,
      totalSpots: map['totalSpots'] as int,
      indoor: map['indoor'] as bool,
      carWash: map['carWash'] as bool,
      evCharge: map['evCharge'] as bool,
      id: map['_id'] != null ? map['_id'] as String : null,
      carparkingFee: map['carparkingFee'] as int,
      bikeparkingFee: map['bikeparkingFee'] as int,
      truckparkingFee: map['truckparkingFee'] as int,
      approved: map['approved'] as bool?, // Nullable bool
      carwashFee: map['carwashFee'] as int?, // Nullable int
    );
  }

  String toJson() => json.encode(toMap());

  factory ParkingModel.fromJson(String source) =>
      ParkingModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
