import 'package:flutter_bloc/flutter_bloc.dart';

class TotalpriceCubit extends Cubit<int> {
  TotalpriceCubit() : super(0);

  updateTotalPrice(int total){
    emit(total);
  }
}