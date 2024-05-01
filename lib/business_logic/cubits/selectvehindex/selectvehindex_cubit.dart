import 'package:flutter_bloc/flutter_bloc.dart';


class SelectvehindexCubit extends Cubit<int> {
  SelectvehindexCubit() : super(0);

  void updateSelectedIndex(int index){
    emit(index);
  }
}