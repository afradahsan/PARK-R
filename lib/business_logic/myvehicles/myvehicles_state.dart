part of 'myvehicles_bloc.dart';

sealed class MyvehiclesState extends Equatable {
  const MyvehiclesState();

  @override
  List<Object> get props => [];
}

final class MyvehiclesInitial extends MyvehiclesState {}

final class MyVehiclesLoading extends MyvehiclesState {}

final class MyVehiclesSuccess extends MyvehiclesState {
  final List<Vehicle> myVehicles;
  const MyVehiclesSuccess({required this.myVehicles});

  @override
  List<Object> get props => [myVehicles];
}

final class MyVehiclesEmptyState extends MyvehiclesState {}

final class MyVehiclesError extends MyvehiclesState {}
