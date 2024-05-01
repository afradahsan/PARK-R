import 'package:flutter_bloc/flutter_bloc.dart';

class BikeChoiceChipCubit extends Cubit<bool>{
  BikeChoiceChipCubit() : super(false);

  void toggle(bool val){
    emit(val);
  }
}

class CarChoiceChipCubit extends Cubit<bool>{
  CarChoiceChipCubit() : super(true);

  void toggle(bool val){
    emit(val);
  }
}

class TruckChoiceChipCubit extends Cubit<bool>{
  TruckChoiceChipCubit() : super(false);

  void toggle(bool val){
    emit(val);
  }
}