part of 'parkingdetails_bloc.dart';

sealed class ParkingdetailsEvent extends Equatable {
  const ParkingdetailsEvent();

  @override
  List<Object> get props => [];
}

class ParkingdescEvent extends ParkingdetailsEvent{
  final int? id;

  const ParkingdescEvent({this.id});
}