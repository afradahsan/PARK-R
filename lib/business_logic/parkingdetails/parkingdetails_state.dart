part of 'parkingdetails_bloc.dart';

sealed class ParkingdetailsState extends Equatable {
  const ParkingdetailsState();
  
  @override
  List<Object> get props => [];
}

final class ParkingdetailsInitial extends ParkingdetailsState {}

final class ParkingDetailsLoadingState extends ParkingdetailsState{}

final class ParkingDetailsSuccessState extends ParkingdetailsState{
  final List<ParkingModel> parkingList;

  const ParkingDetailsSuccessState({required this.parkingList});

  @override
  List<Object> get props => [parkingList];
}

final class ParkingDetailsErrorState extends ParkingdetailsState{}