import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkr/data/models/vehiclemodel.dart';
import 'package:parkr/data/repositories/myvehicles/myvehicle_repo.dart';

part 'myvehicles_event.dart';
part 'myvehicles_state.dart';

class MyvehiclesBloc extends Bloc<MyvehiclesEvent, MyvehiclesState> {
  final BuildContext context;

  MyvehiclesBloc(this.context) : super(MyvehiclesInitial()) {
    on<MyvehiclesEvent>(myvehiclesevent);
  }

  FutureOr<void> myvehiclesevent(
      MyvehiclesEvent event, Emitter<MyvehiclesState> emit) async {
    emit(MyVehiclesLoading());

    List<Vehicle> myvehiclesList = await MyVehicleRepo().getVehicles(context);

    try {
      if (myvehiclesList.isNotEmpty) {
        debugPrint('myvehicledone');
        emit(MyVehiclesSuccess(myVehicles: myvehiclesList));
      } else {
        debugPrint('myv empty');
        emit(MyVehiclesEmptyState());
      }
    } catch (e) {
      emit(MyVehiclesError());
    }
  }
}
