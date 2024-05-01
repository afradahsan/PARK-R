import 'package:flutter_bloc/flutter_bloc.dart';

class IndoorCubit extends Cubit<bool> {
  IndoorCubit() : super(false);

  void toggle() {
    emit(!state);
  }
}

class CarWashCubit extends Cubit<bool> {
  CarWashCubit() : super(false);

  void toggle() {
    emit(!state);
  }
}

class EvChargeCubit extends Cubit<bool> {
  EvChargeCubit() : super(false);

  void toggle() {
    emit(!state);
  }
}