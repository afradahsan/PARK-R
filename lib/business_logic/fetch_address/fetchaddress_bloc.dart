import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:parkr/presentation/screens/home/home.dart';

part 'fetchaddress_event.dart';
part 'fetchaddress_state.dart';

class FetchaddressBloc extends Bloc<FetchaddressEvent, FetchaddressState> {
  final BuildContext context;

  FetchaddressBloc(this.context) : super(FetchaddressInitial()) {
    on<FetchaddressEvent>(fetchaddress);
  }

  Future<void> fetchaddress(
      FetchaddressEvent event, Emitter<FetchaddressState> emit) async {
    emit(FetchaddressLoading());

    try {
      final position = await fetchPosition(context);
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      debugPrint('list ${placemarks}');
      String address = '';
      address += placemarks.reversed.last.subLocality == '' ? placemarks.reversed.last.administrativeArea! : '';

      emit(FetchaddressSuccess(address));
    } catch (e) {
      emit(FetchaddressError(e.toString()));
    }
  }
}
