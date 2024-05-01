import 'package:flutter_bloc/flutter_bloc.dart';

class ApproveParkingCubit extends Cubit<bool>{
  ApproveParkingCubit() : super(false);

  void approve(){
    emit(!state);
  }

  void disapprove(){
    emit(state);
  }
}