part of 'bookings_bloc.dart';

sealed class BookingsState extends Equatable {
  const BookingsState();

  @override
  List<Object> get props => [];
}

final class BookingsInitial extends BookingsState {}

final class BookingsLoadingState extends BookingsState {}

final class BookingsEmptyState extends BookingsState {}

final class BookingSuccessState extends BookingsState {
  final List<BookingModel> bookingList;

  const BookingSuccessState({required this.bookingList});

  @override
  List<Object> get props => [bookingList];
}

final class BookingErrorState extends BookingsState {}