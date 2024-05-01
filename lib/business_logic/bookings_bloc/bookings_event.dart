part of 'bookings_bloc.dart';

sealed class BookingsEvent extends Equatable {
  const BookingsEvent();

  @override
  List<Object> get props => [];
}

class BookingdetailsEvent extends BookingsEvent{
  final BuildContext context;

  const BookingdetailsEvent({required this.context});
}