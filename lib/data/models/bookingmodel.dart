// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BookingModel {
  final String user;
  final String parkingLot;
  final String startTime;
  final String endTime;
  final String startDate;
  final String endDate;
  final String vehicleNumber;
  final String qrCodeData;
  final String status;
  final String paymentStatus;
  final int totalPrice;
  final String? razorpayId;

  BookingModel(
      {required this.user,
      required this.parkingLot,
      required this.startTime,
      required this.endTime,
      required this.startDate,
      required this.endDate,
      required this.vehicleNumber,
      required this.qrCodeData,
      required this.status,
      required this.paymentStatus,
      required this.totalPrice, this.razorpayId,});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user,
      'parkingLot': parkingLot,
      'startTime': startTime,
      'endTime': endTime,
      'startDate': startDate,
      'endDate': endDate,
      'vehicleNumber': vehicleNumber,
      'qrCodeData': qrCodeData,
      'status': status,
      'paymentStatus': paymentStatus,
      'totalPrice': totalPrice,
      'razorpayId': razorpayId
    };
  }

  factory BookingModel.fromMap(Map<String, dynamic> map) {
    return BookingModel(
      user: map['user'] as String,
      parkingLot: map['parkingLot'] as String,
      startTime: map['startTime'] as String,
      endTime: map['endTime'] as String,
      startDate: map['startDate'] as String,
      endDate: map['endDate'] as String,
      vehicleNumber: map['vehicleNumber'] as String,
      qrCodeData: map['qrCodeData'] as String,
      status: map['status'] as String,
      paymentStatus: map['paymentStatus'] as String,
      totalPrice: map['totalPrice'] as int,
      razorpayId: map['razorpayId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BookingModel.fromJson(String source) =>
      BookingModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
