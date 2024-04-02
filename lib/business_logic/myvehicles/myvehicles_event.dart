part of 'myvehicles_bloc.dart';

sealed class MyvehiclesEvent extends Equatable {
  const MyvehiclesEvent();

  @override
  List<Object> get props => [];
}

class FetchVehiclesEvent extends MyvehiclesEvent{
  const FetchVehiclesEvent();
}