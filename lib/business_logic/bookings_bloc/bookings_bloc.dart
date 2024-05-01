import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkr/data/models/bookingmodel.dart';
import 'package:parkr/data/repositories/bookings/booking_repo.dart';

part 'bookings_event.dart';
part 'bookings_state.dart';

class BookingsBloc extends Bloc<BookingsEvent, BookingsState> {
  BookingsBloc() : super(BookingsInitial()) {
    on<BookingsEvent>(bookingevent);
  }

  FutureOr<void> bookingevent(
      BookingsEvent event, Emitter<BookingsState> emit) async {
    if (event is BookingdetailsEvent) {
      try {
        final List<BookingModel> bookingList =
            await BookingRepo().fetchBookings(event.context);
        if (bookingList.isNotEmpty) {
          emit(BookingSuccessState(bookingList: bookingList));
        } else {
          emit(BookingErrorState());
        }
      } catch (e) {
        emit(BookingErrorState());
      }
    }
  }
}
