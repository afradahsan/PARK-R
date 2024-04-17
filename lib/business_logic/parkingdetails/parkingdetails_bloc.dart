import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkr/data/models/parkingmodel.dart';
import 'package:parkr/data/repositories/admin/admin_repo.dart';

part 'parkingdetails_event.dart';
part 'parkingdetails_state.dart';

class ParkingdetailsBloc
    extends Bloc<ParkingdetailsEvent, ParkingdetailsState> {
  final BuildContext context;

  ParkingdetailsBloc(this.context) : super(ParkingdetailsInitial()) {
    on<ParkingdescEvent>(parkingdescevent);
  }
  
  FutureOr<void> parkingdescevent(
      ParkingdescEvent event, Emitter<ParkingdetailsState> emit) async {
    emit(ParkingDetailsLoadingState());

    List<ParkingModel> parkingList = await AdminRepo().fetchParkingLots(context);

    if (parkingList.isNotEmpty) {
      debugPrint('done');
      emit(ParkingDetailsSuccessState(parkingList: parkingList));
    } else {
      debugPrint('not done');
      emit(ParkingDetailsErrorState());
    }
  }
}