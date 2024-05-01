import 'package:flutter_bloc/flutter_bloc.dart';

class WashCubit extends Cubit<bool> {
  WashCubit() : super(false);

  updateIncWash(){
    emit(!state);
  }
}